require 'http'

module WiKey
  class ApiGateway
    def initialize(config = WiKey::App.config)
      @config = config
    end
    
    def all_articles
      call_api(:get, 'topic')
    end
    
    def article(topic)
      call_api(:get, ['topic', topic])
    end
    
    def create_article(topic)
      call_api(:post, ['topic', topic])
    end
    
    def call_api(method, resources)
      url_route = [@config.api_url, resources].flatten.join'/'
      
      result = HTTP.send(method, url_route)
      raise(result.to_s) if result.code >= 300
      result.to_s
    end
  end
end