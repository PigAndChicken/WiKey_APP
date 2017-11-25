module WiKey
  module Views
    # view object for a single wiki's topic
    class Subject
      def initialize(topic)
        @topic = topic
      end
      
      def topic
        @topic.topic
      end
      
      def link_to_topic_default
        "/topic/#{topic}"
      end
    end
  end
end