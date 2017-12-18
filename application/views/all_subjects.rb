module WiKey
  module Views
    # View object for collection of Wiki subjects
    class AllSubjects
      def initialize(all_topics)
        @all_topics = all_topics
      end

      def none?
        @all_topics.topics.none?
      end
=begin
      def any?
        @all_topics.topics.any?
      end
=end
      def collection
        @all_topics.topics.map { |topic| Subject.new(topic) }
      end
    end
  end
end
