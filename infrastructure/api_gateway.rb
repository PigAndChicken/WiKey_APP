require 'http'

module WiKey
  class ApiGateway
    def initialize(config = WiKey::App.config)
      @config = config
    end

    def all_topics
      call_api(:get, 'topics')
    end

    def topic(topic_name)
      call_api(:get, ['topic', topic_name])
    end

    def create_topic(topic_name)
      call_api(:post, ['topic', topic_name])
    end
    
    def paragraph(topic_name, catalog_name)
      call_api(:get, ['paragraphs', topic_name, catalog_name])
    end

    def call_api(method, resources)
      url_route = [@config.api_url, resources].flatten.join'/'

      result = HTTP.send(method, url_route)
      #raise(result.to_s) if result.code >= 300
      result.to_s
    end
  end
end