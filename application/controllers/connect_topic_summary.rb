module WiKey
  # Web App
  class App < Roda
    # GET or POST /topic
    route('topic') do |routing|
      routing.on String do |topic_name|
        routing.get do

          result = CheckTopic.new.call(topic_name).value
          if result.message.include? 'Remote article not found'
            flash[:error] = 'Not exists in Wikipedia'
            routing.redirect '/'
          else
            topic_info = result
            topic_info = ArticleRepresenter.new(OpenStruct.new)
                                           .from_json topic_info.message

            subject_contents = Views::SubjectContents.new(topic_info)
            view 'topic_summary', locals: { subject_contents: subject_contents }
        end
      end
    end
  end
end
