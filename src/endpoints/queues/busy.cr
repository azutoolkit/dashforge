module Queues
  struct BusyEndpoint
    include Azu::Endpoint(Azu::Request, Queues::Busy)

    def call : Queues::Index
      Queues::Busy.new
    end
  end
end
