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
    include Azu::Endpoint(QueueIndexRequest, Queues::Index | Azu::BadRequest)

    def call : Queues::Index | Azu::BadRequest
      return Azu::BadRequest.new(request.errors_messages) unless request.valid?
      Queues::Index.new(request.name)
    end
  end
end
