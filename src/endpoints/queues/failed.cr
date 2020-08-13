module Queues
  struct FailedEndpoint
    include Azu::Endpoint(Azu::Request, Queues::Failed)

    def call : Queues::Failed
      Queues::Failed.new
    end
  end
end
