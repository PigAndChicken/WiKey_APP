module WiKey
  module Views
    # view object for hot topics
    class HotTopics
      def initialize(hot_topics)
        @hot_topics = hot_topics
      end

      def all_hot_topics
        @hot_topics.topics
      end

      def hot_topic_names
        @hot_topics.topics.map(&:name)
      end
    end
  end
end
