module WiKey
  # Web App
  class App < Roda
    # GET /see_also/:topic_name
    route('see_also') do |routing|
      routing.on String do |topic_name|
        routing.get do
          result = ApiGateway.new.see_also(topic_name)
          view_info = { result: result }
          if result.processing?
    #        view_info[:processing] = Views::ProcessingView.new(result)
            flash.now[:notice] = 'Checking hot topics, please check back later.'
          else
            see_also = TopicsRepresenter.new(OpenStruct.new)
                                        .from_json result.message
            view_info[:see_also] = see_also
            view_info[:see_also_names] = see_also.topics.map(&:name)
          end

          view 'see_also', locals: view_info
        end
      end
    end
  end
end
