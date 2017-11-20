module WiKey
  module Views
    # view object for a single wiki's topic
    class SubjectContents
      def initialize(topic_info)
        @topic_info = topic_info
      end
      
      def topic
        @topic = @topic_info['topic']['name']  #"topic_name"
      end
      
      def catalogs
        @topic_info['catalogs'].map{ |c| c['name'] }  #[c1, c2, c3]
      end
      
      def catalog
        @topic_info['paragraphs'][0]['catalog']
      end
      
      def paragraph
        @topic_info['paragraphs'].map{ |p| p['content'] }.flatten.join("\n\n")  #"paragraph"
      end
      
      def link_to_topic_paragraph
        "/paragraphs/#{topic}/#{catalog}"
      end
    end
  end
end