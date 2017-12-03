module WiKey
  
  module Views
  
    class AllSubjects
      
      def initialize(topics)
        @all_topics = topics
      end
      
      def none?
        @all_topics.topics.none?
      end
      
      def any?
        @all_topics.topics.any?
      end
      
      def collection
        @all_topics.topics.map {|topic| Subject.new(topic)}
      end
    end
  end
end