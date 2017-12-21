module WiKey
  module Views
    # view object for process bar information
    class ProcessingView
      def initialize(result)
        @result = result
      end

      def channel_id
        JSON.parse(@result.message)['message']['id']
      end

      def host
        App.config.API_HOST
      end
    end
  end
end
