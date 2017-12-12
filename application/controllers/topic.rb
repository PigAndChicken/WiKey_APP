module WiKey
  # Web App
  class App < Roda
    # GET or POST /topic
    route('topic') do |routing|
      routing.post do
        topic_name = routing.params['topic']

        result = CheckTopic.new.call(topic_name)
        if result.value.include? 'Remote article not found'
          flash[:error] = 'Not exists in Wikipedia'
          routing.redirect '/'
        else
          topic_info = result.value
          topic_info = ArticleRepresenter.new(OpenStruct.new)
                                         .from_json topic_info
        end
        subject_contents = Views::SubjectContents.new(topic_info)
        view 'home', locals: { home: false,
                               subject_contents: subject_contents }
      end
    end
  end
end
