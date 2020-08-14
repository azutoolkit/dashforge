module Jobs
  struct IndexEndpoint
    include Azu::Endpoint(Azu::Request, Jobs::Index)

    def call : Jobs::Index
      Jobs::Index.new
    end
  end
end
