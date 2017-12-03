require 'dry/transaction'

module WiKey
  
  class SearchTopic
    include Dry::Transaction
    
    step :get_data
    step :post_data
    
    def get_data(topic_name)
      topic_json = ApiGateway.new.summaries(topic_name,'default')
      if topic_json.include? 'error'
        Right(topic_name)
      else
        topic_info = ArticleRepresenter.new(OpenStruct.new).from_json topic_json
        Left(topic_info)
      end
    end
    
    def post_data(topic_name)
      result = ApiGateway.new.creat_topic(topic_name)
      if result.include? 'error'
        Left(result)
      else
        topic_json = ApiGateway.new.summaries(topic_name,'default')
        topic_info = ArticleRepresenter.new(OpenStruct.new).from_json topic_json
        Right(topic_info)
      end
    end
  
  end
end