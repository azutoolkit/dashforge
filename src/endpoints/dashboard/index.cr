module Dashboard
  struct Index
    include Azu::Endpoint(Azu::Request, DashboardPage)

    def call : DashboardPage
      DashboardPage.new
    end
  end
end
