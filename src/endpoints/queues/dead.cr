module Queues
  struct DeadEndpoint
    include Azu::Endpoint(Azu::Request, Queues::Dead)

    def call : Queues::Dead
      Queues::Dead.new
    end
  end
end
