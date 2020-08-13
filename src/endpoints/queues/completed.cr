module Queues
  struct CompletedEndpoint
    include Azu::Endpoint(Azu::Request, Queues::Completed)

    def call : Queues::Completed
      Queues::Completed.new
    end
  end
end
