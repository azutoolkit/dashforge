module DashForge
  class Scheduler::Index
    include Endpoint(EmptyRequest, IndexPage)

    def call : IndexPage
      IndexPage.new
    end
  end
end
