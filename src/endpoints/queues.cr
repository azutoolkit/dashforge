require "azu/params"

module DashForge
  module Queues
    struct TraceRequest
      include Request
      getter name : String

      def error_messages
        errors.map(&.message)
      end
    end

    struct ShowRequest
      include Request
      getter queue : String

      def errors_messages
        errors.messages.join(", ")
      end
    end

    class Traces
      include Azu::Endpoint(TraceRequest, Queues::TracesPage)
      get "/queues/traces/:name"

      def call : Queues::TracesPage
        raise error("No queue trace name!", 400, trace_request.error_messages) unless trace_request.valid?
        Queues::TracesPage.new(trace_request.name)
      end
    end

    class Show
      include Endpoint(ShowRequest, Queues::ShowPage)
      get "/queues/:queue"

      def call : Queues::ShowPage
        raise error("No queue name!", 400, show_request.errors.map(&.message)) unless show_request.valid?
        Queues::ShowPage.new(show_request.queue)
      end
    end
  end
end
