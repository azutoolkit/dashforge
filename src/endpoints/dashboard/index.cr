module Dashboard
  struct Index
    include Azu::Endpoint(Azu::Request, Dashboard::IndexPage)

    def call : Dashboard::IndexPage
      Dashboard::IndexPage.new
    end
  end
end
