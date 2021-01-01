require "azu/params"

module JoobqGui
  module Queues
    struct ShowRequest
      include Request

      getter queue : String

      def errors_messages
        errors.messages.join(", ")
      end
    end

    class Show
      include Azu::Endpoint(ShowRequest, Queues::ShowPage)

      def call : Queues::ShowPage
        raise error("No queue name!", 400, show_request.errors.map(&.message)) unless show_request.valid?
        Queues::ShowPage.new(show_request.queue)
      end
    end
  end
end
