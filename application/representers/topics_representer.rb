require_relative 'topic_representer'

# Represents essential Repo information for API output
module WiKey
  class TopicsRepresenter < Roar::Decorator
    include Roar::JSON

    collection :topics, extend: TopicRepresenter, class: OpenStruct
  end
end