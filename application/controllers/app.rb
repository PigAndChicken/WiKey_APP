require 'roda'
require 'slim'
require 'slim/include'

module WiKey
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'presentation/views'
    plugin :assets, css: 'style.css', path: 'presentation/assets'
    plugin :all_verbs
    plugin :multi_route
    plugin :flash
    use Rack::Session::Cookie, secret: config.SESSION_SECRET

    require_relative 'summaries'
    require_relative 'topic'
    require_relative 'hot_topics'
    require_relative 'see_also'
    require_relative 'summaries_percent'

    route do |routing|
      routing.assets

      # GET request
      routing.root do
        topics_json = ApiGateway.new.all_topics
        all_topics = TopicsRepresenter.new(OpenStruct.new)
                                      .from_json topics_json.message
        subjects = Views::AllSubjects.new(all_topics)

        view 'home', locals: { subjects: subjects }
      end

      routing.on do
        routing.multi_route
      end
    end
  end
end
