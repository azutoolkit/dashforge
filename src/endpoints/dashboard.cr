module DashForge

  class Dashboard::Index
    include Endpoint(Request, IndexPage)
    get "/"
    
    def call : IndexPage
      IndexPage.new
    end
  end
end
