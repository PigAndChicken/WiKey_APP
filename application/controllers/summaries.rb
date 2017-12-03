module WiKey
  
  class App < Roda
  
    route('summaries') do |routing|
      
      routing.on String, String do |topic_name, catalog_name|
        topic_json = ApiGateway.new.summaries(topic_name,catalog_name)
        topic = ArticleRepresenter.new(OpenStruct.new).from_json topic_json
        
        subject_contents = Views::SubjectContents.new(topic, catalog_name)
        
        view 'home', locals: { home: false, subject_contents: subject_contents }
      end
      
    end
  end
end