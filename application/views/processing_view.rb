module WiKey
  module Views
    # view object for process bar information
    class ProcessingView
      def initialize(result)
        @result = result
      end

      def ws_channel_id
        "-758121688208626020"
#        JSON.parse(@result.message)['message']['id']
      end

      def ws_host
        App.config.API_HOST
      end
    end
  end
end
