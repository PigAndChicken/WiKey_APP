require 'concurrent'

module WiKey
  
  class App < Roda
  
    route('article') do |routing|
      
      routing.post do
        topic_name = routing.params['topic']
        topic_info = SearchTopic.new.call(topic_name)
        if topic_info.value.class == String
          flash.now[:error] = "error"
          subject_contents = nil
        else
          subject_contents = Views::SubjectContents.new(topic_info.value, 'default')
        end
        view 'home', locals: { home: false, subject_contents: subject_contents }
      end
      
    end
  end
end