require 'roda'
require 'slim'

module WiKey
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'presentation/views'
    plugin :assets, css: 'style.css', path: 'presentation/assets'

    route do |routing|
      routing.assets

      # GET request
      routing.root do
        topics_json = ApiGateway.new.all_topics
        all_topics = TopicsRepresenter.new(OpenStruct.new).from_json topics_json
        subjects = Views::AllSubjects.new(all_topics)
        
        view 'home', locals: { home: true, subjects: subjects }
      end
      
      routing.on 'paragraphs', String, String do |topic_name, catalog_name|
        routing.get do
          topic_info = ApiGateway.new.paragraph(topic_name, catalog_name)
          topic_info = JSON.parse topic_info
          subject_contents = Views::SubjectContents.new(topic_info)

          view 'home', locals: { home: false, subject_contents: subject_contents }
        end
      end
      
#      routing.on 'catalogs', String do |topic_name|
#        routing.get do
#          topic_info = ApiGateway.new.topic(topic_name)
#          topic_info = JSON.parse topic_info

#          view 'home', locals: { home: false, topic: topic_info['topic'], catalogs: topic_info['catalogs'], paragraphs: topic_info['paragraphs'].map{ |p| p['content'] }.flatten.join("\n\n") }
#        end
#      end
      
      routing.on 'topic' do
        routing.post do
          topic_name = routing.params['topic']
          topic_info = ApiGateway.new.topic(topic_name)
          topic_info = JSON.parse topic_info
          if topic_info.keys.include?('error')
            topic_info = ApiGateway.new.create_topic(topic_name)
            topic_info = JSON.parse topic_info
          end

          view 'home', locals: { home: false, topic: topic_info['topic'], catalogs: topic_info['catalogs'], paragraphs: topic_info['paragraphs'].map{ |p| p['content'] }.flatten.join("\n\n") }
        end
      end
    end
  end
end