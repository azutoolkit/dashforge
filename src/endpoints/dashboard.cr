module DashForge

  class Dashboard::Index
    include Endpoint(Request, IndexPage)

    def call : IndexPage
      IndexPage.new
    end
  end
end
