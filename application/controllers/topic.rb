module WiKey
  # Web App
  class App < Roda
    # GET or POST /topic
    route('topic') do |routing|
      routing.post do
        topic_input = Forms::InputReg.call(routing.params)
        result = CheckTopic.new.call(topic_input).value

        if result.include? 'special notations'
          flash[:error] = 'Invalid input started/ended with special notations.'
          routing.redirect '/'
        elsif result.include? 'Remote article not found'
          flash[:error] = 'Not exists in Wikipedia'
          routing.redirect '/'
        else
          topic_info = ArticleRepresenter.new(OpenStruct.new).from_json result
          subject_contents = Views::SubjectContents.new(topic_info)

          origin_info = ApiGateway.new.paragraphs(topic_input.output[:topic], 'default')
          origin_info = ArticleRepresenter.new(OpenStruct.new)
                                          .from_json origin_info.message
          origin_contents = Views::OriginContents.new(origin_info)

          view 'topic_summary', locals: { subject_contents: subject_contents,
                                          origin_contents: origin_contents,
                                          topic_page: true }
        end
      end
    end
  end
end
