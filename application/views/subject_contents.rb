module WiKey
  
  module Views
    
    class SubjectContents
       
       def initialize(topic_info,catalog)
         @topic_info = topic_info
         @catalog = catalog
       end
       
       def topic
         @topic_info.topic.name
       end
       
       def catalog_collection
         @topic_info.catalogs.map {|catalog| SubjectContents.new(@topic_info, catalog.name) }
       end
       
       def catalog
         @catalog
       end
       
       def find_catalog(catalog_name)
         catalog_name = catalogs.select { |catalog| catalog.name == catalog_name }
         if catalog_name.nil?
           return 'catalog not found'
         else
           catalog[0].name
         end
       end
       
       def paragraphs
         @topic_info.paragraphs
       end
       
       def link_to_summaries
         "/summaries/#{topic}/#{@catalog}"
       end
       
    end
  end
end