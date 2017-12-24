module WiKey
  # Web App
  class App < Roda
    # GET or POST /hot_topics
    route('hot_topics') do |routing|
      routing.get do
        result = ApiGateway.new.hot_topics
        view_info = { result: result }
        if result.processing?
  #        view_info[:processing] = Views::ProcessingView.new(result)
          flash.now[:notice] = 'Checking hot topics, please check back later.'
        else
          hot_topics = TopicsRepresenter.new(OpenStruct.new)
                                        .from_json result.message
          view_info[:hot_topics] = hot_topics
        end

        view 'hot_topics', locals: { view_info: view_info }
      end
    end
  end
end
