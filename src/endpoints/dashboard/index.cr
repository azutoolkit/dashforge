module Dashboard
  struct IndexEndpoint
    include Azu::Endpoint(Azu::Request, Dashboard::Index)

    def call : Dashboard::Index
      Dashboard::Index.new
    end
  end
end
