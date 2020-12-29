require "azu/params"

module JoobqGui
  module Queues
    struct ShowRequest
      include Request

      getter name : String?

      def errors_messages
        errors.messages.join(", ")
      end
    end

    struct Show
      include Azu::Endpoint(ShowRequest, Queues::ShowPage)

      def call : Queues::ShowPage
        Queues::ShowPage.new(request.name.not_nil!)
      end

      private def request
        ShowRequest.new(params)
      end
    end
  end
end
