module Queues
  struct IndexEndpoint
    include Azu::Endpoint(Azu::Request, Queues::Index)

    def call : Queues::Index
      Queues::Index.new
    end
  end
end
