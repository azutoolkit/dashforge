module Jobs
  struct ShowEndpoint
    include Azu::Endpoint(Azu::Request, Jobs::Show)

    def call : Jobs::Show
      Jobs::Show.new
    end
  end
end
