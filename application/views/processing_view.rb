module WiKey
  module Views
    # view object for process bar information
    class ProcessingView
      def initialize(result)
        @result = result
      end

      def ws_channel_id
        JSON.parse(@result.message)['message'][0]['id']
      end

      def ws_host
        App.config.API_HOST
      end
    end
  end
end
