module DashForge
  class Scheduler::Index
    include Endpoint(Request, IndexPage)

    get "/scheduled"

    def call : IndexPage
      IndexPage.new
    end
  end
end
