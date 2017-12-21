require 'dry/transaction'

module WiKey
  # check if topic loaded or not, if not loaded yet, load it from api
  class CheckTopic
    include Dry::Transaction

    step :check_if_exists
    step :create_topic

    def check_if_exists(topic_name)
      topic_info = ApiGateway.new.topic(topic_name)
      if topic_info.message.include? 'Could not find'
        Right(topic_name) # not loaded yet, go next step to create
      else
        Left(topic_info) # out with info
      end
    end

    def create_topic(topic_name)
      topic_info = ApiGateway.new.create_topic(topic_name)
      if topic_info.message.include? 'not found'
        Left(topic_info) # not exist in Wikipedia, out with error msg
      else
        Right(topic_info)
      end
    end
  end
end
