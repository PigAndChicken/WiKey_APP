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

          origin_info = ApiGateway.new.paragraphs(topic_name, catalog_name)
          origin_info = ArticleRepresenter.new(OpenStruct.new)
                                          .from_json origin_info.message
          origin_contents = Views::OriginContents.new(origin_info)

          view 'topic_summary', locals: { subject_contents: subject_contents,
                                          origin_contents: origin_contents }
        end
      end
    end
  end
end
