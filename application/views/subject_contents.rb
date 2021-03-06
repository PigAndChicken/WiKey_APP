module WiKey
  module Views
    # view object for a single wiki's topic
    class SubjectContents
      def initialize(topic_info)
        @topic_info = topic_info
      end

      def topic
        @topic_info['topic']['name'] # "topic_name"
      end

      def catalogs
        @topic_info['catalogs'].map { |c| c['name'] } # [c1, c2, c3]
      end

      def catalog_id
        @topic_info['paragraphs'][0]['catalog'].tr(' ', '_')
      end

      def current_catalog
        @topic_info['paragraphs'][0]['catalog']
      end

      def summaries
        @topic_info['paragraphs'].map { |p| p['content'] } # [p1, p2, p3]
      end
    end
  end
end
