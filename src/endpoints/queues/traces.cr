require "azu/params"

module JoobqGui
  module Queues
    struct TraceRequest
      include Request
      getter name : String

      def error_messages
        errors.map(&.message)
      end
    end

    class Traces
      include Azu::Endpoint(TraceRequest, Queues::TracesPage)

      def call : Queues::TracesPage
        raise error("No queue trace name!", 400, trace_request.error_messages) unless trace_request.valid?
        Queues::TracesPage.new(trace_request.name)
      end
    end
  end
end
