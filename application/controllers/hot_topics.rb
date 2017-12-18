=begin
module WiKey
  # Web App
  class App < Roda
    # GET or POST /hot_topics
    route('hot_topics') do |routing|
      routing.get do
        result = ApiGateway.new.hot_topics(topics_num)
        if result.processing?
          flash.now[:notice] = 'Checking hot topics, please ckeck back in a moment.'
        else

        end

      end
