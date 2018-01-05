module WiKey
  # Web App
  class App < Roda
    # GET or POST /hot_topics
    route('hot_topics') do |routing|
      routing.get do
        result = ApiGateway.new.hot_topics
        hot_topics = TopicsRepresenter.new(OpenStruct.new)
                                      .from_json result.message
        hot_topics = Views::SubjectContents.new(hot_topics)

        view 'hot_topics', locals: { hot_topics: hot_topics }
      end
    end
  end
end
