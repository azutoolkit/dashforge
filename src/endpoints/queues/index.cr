require "azu/params"

module Queues
  struct QueueIndexRequest
    include Azu::Request

    def name
      params.path["name"]
    end

    def errors_messages
      errors.messages.join(", ")
    end
  end

  struct IndexEndpoint
    include Azu::Endpoint(QueueIndexRequest, Queues::Index)

    def call : Queues::Index
      Queues::Index.new(request.name)
    end
  end
end
