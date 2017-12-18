require 'http'

module WiKey
  class ApiGateway
    class ApiResponse
      HTTP_STATUS = {
        200 => :ok,
        201 => :created,
        202 => :processing,
        204 => :no_content,

        403 => :forbidden,
        404 => :not_found,
        400 => :bad_request,
        409 => :conflict,
        422 => :cannot_process,

        500 => :internal_error
      }.freeze

      attr_reader :status, :message

      def initialize(code, message)
        @code = code
        @status = HTTP_STATUS[code]
        @message = message
      end

      def ok?
        HTTP_STATUS[@code] == :ok
      end

      def processing?
        HTTP_STATUS[@code] == :processing
      end
    end

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

    def summaries(topic_name, catalog_name)
      call_api(:get, ['summaries', topic_name, catalog_name])
    end

=begin
# call api, get hot topics
    def hot_topics(topics_num)
      call_api(:get, [topics_num])
    end
=end
    def call_api(method, resources)
      url_route = [@config.API_URL, resources].flatten.join'/'

      result = HTTP.send(method, url_route)
      raise(ApiResponse::HTTP_STATUS[result.code]) if result.code >= 300
      ApiResponse.new(result.code, result.to_s)
    end
  end
end
