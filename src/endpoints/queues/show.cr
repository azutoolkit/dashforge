require "azu/params"

module Queues
  struct ShowRequest
    include Azu::Request

    def name
      params.path["name"]
    end

    def errors_messages
      errors.messages.join(", ")
    end
  end

  struct Show
    include Azu::Endpoint(ShowRequest, Queues::ShowPage)

    def call : Queues::ShowPage
      Queues::ShowPage.new(request.name)
    end
  end
end
