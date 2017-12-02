require 'roda'
require 'slim'
require 'slim/include'

module WiKey
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'presentation/views'
    plugin :assets, css: 'style.css', path: 'presentation/assets'
    plugin :flash
    use Rack::Session::Cookie, secret: config.SESSION_SECRET

    route do |routing|
      routing.assets

      # GET request
      routing.root do
        topics_json = ApiGateway.new.all_topics
        all_topics = TopicsRepresenter.new(OpenStruct.new).from_json topics_json
        subjects = Views::AllSubjects.new(all_topics)

        flash.now[:notice] = "Let's enter a topic to try" if subjects.any?

        view 'home', locals: { home: true, subjects: subjects }
      end

      routing.on 'summaries', String, String do |topic_name, catalog_name|
        routing.get do
          topic_info = ApiGateway.new.summaries(topic_name, catalog_name)
          topic_info = ArticleRepresenter.new(OpenStruct.new)
                                         .from_json topic_info
          subject_contents = Views::SubjectContents.new(topic_info)

          view 'home', locals: { home: false,
                                 subject_contents: subject_contents }
        end
      end

      routing.on 'topic' do
        routing.post do
          topic_name = routing.params['topic']
          topic_info = ApiGateway.new.topic(topic_name)
          topic_info = ArticleRepresenter.new(OpenStruct.new)
                                         .from_json topic_info

          if topic_info.topic.nil?
            result = CreateTopic.new.call(topic_name)
            if result.failure?
              flash[:error] = 'Not exists in Wikipedia'
              routing.redirect '/'
            else
              topic_info = result.value
            end
          end

          unless topic_info.topic.nil?
            subject_contents = Views::SubjectContents.new(topic_info)
            view 'home', locals: { home: false,
                                   subject_contents: subject_contents }
          end
        end
      end
    end
  end
end
