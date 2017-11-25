require 'dry/transaction'

module WiKey
  class CreateTopic
    include Dry::Transaction
    
#    step :search_topic
    step :create_topic
    
#    def search_topic(topic_name)
#      topic_info = ApiGateway.new.topic(topic_name)
#      topic_info = ArticleRepresenter.new(OpenStruct.new).from_json topic_info
#      Right(topic_info: topi)
#    end
    
    def create_topic(topic_name)
      topic_info = ApiGateway.new.create_topic(topic_name)
      if topic_info.include? 'error'
        Left(topic_info)
      else
        topic_info = ArticleRepresenter.new(OpenStruct.new).from_json topic_info
        Right(topic_info)
      end
    end
  end
end