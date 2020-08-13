module Queues
  struct BusyEndpoint
    include Azu::Endpoint(Azu::Request, Queues::Busy)

    def call : Queues::Busy
      Queues::Busy.new
    end
  end
end
