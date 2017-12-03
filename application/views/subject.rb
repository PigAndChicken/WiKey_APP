module WiKey
  
  module Views
    
    class Subject
      
      def initialize(topic)
        @topic = topic
      end
      
      def topic
        @topic.name
      end
      
      def link_to_topic_default
        "/topic/#{self.topic}"
      end
      
    end
  end
end