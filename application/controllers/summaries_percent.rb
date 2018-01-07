module WiKey
  # Web App
  class App < Roda
    # GET /summaries_percent/:topic_name/:catalog_name/:percentage
    route('summaries_percent') do |routing|
      routing.on String, String, Integer do |topic_name, catalog_name, percentage|
        routing.get do
          topic_info = ApiGateway.new.summaries_percent(topic_name, catalog_name, percentage)
          topic_info = ArticleRepresenter.new(OpenStruct.new)
                                         .from_json topic_info.message
          subject_contents = Views::SubjectContents.new(topic_info)

          content = subject_contents.summaries.to_s
          content
        end
      end
    end
  end
end
