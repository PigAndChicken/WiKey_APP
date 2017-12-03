# represent essential Wiki article information for API output
require_relative 'topic_representer'
require_relative 'catalog_representer'
require_relative 'paragraph_representer'

module WiKey
  class ArticleRepresenter < Roar::Decorator
    include Roar::JSON
    
    property :topic, extend: TopicRepresenter, class: OpenStruct
    collection :catalogs, extend: CatalogRepresenter, class: OpenStruct
    collection :paragraphs, extend: ParagraphRepresenter, class: OpenStruct
  end
end