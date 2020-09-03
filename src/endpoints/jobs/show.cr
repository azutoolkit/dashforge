module Jobs
  struct Show
    include Azu::Endpoint(Azu::Request, Jobs::ShowPage)

    def call : Jobs::ShowPage
      Jobs::ShowPage.new
    end
  end
end
