module DashForge
  struct EmptyRequest
    include Request
  end

  class Dashboard::Index
    include Endpoint(EmptyRequest, IndexPage)

    def call : IndexPage
      IndexPage.new
    end
  end
end
