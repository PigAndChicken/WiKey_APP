module WiKey
  module Views
    # view object for a single wiki's topic
    class OriginContents
      def initialize(origin_info)
        @origin_info = origin_info
      end

      def topic
        @origin_info['topic']['name'] # "topic_name"
      end

      def catalogs
        @origin_info['catalogs'].map { |c| c['name'] } # [c1, c2, c3]
      end

      def current_catalog
        @origin_info['paragraphs'][0]['catalog']
      end

      def origin_paragraphs
        @origin_info['paragraphs'].map { |p| p['content'] }
      end
    end
  end
end
