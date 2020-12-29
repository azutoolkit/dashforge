module JoobqGui
  struct Jobs::Show
    include Endpoint(EmptyRequest, Jobs::ShowPage)

    def call : Jobs::ShowPage
      Jobs::ShowPage.new
    end
  end
end
