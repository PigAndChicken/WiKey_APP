module WiKey
  # Web App
  class App < Roda
    # GET /summaries/:topic_name/:catalog_name
    route('summaries') do |routing|
      routing.on String, String do |topic_name, catalog_name|
        routing.get do
          topic_info = ApiGateway.new.summaries(topic_name, catalog_name)
          topic_info = ArticleRepresenter.new(OpenStruct.new)
                                         .from_json topic_info.message
          subject_contents = Views::SubjectContents.new(topic_info)

          view 'topic_summary', locals: { home: false,
                                 subject_contents: subject_contents }
        end
      end
    end
  end
end
