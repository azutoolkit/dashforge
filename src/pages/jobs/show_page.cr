module JoobqGui
  struct Jobs::ShowPage
    include Response::Html

    def html
      render "jobs/show.jinja", {} of String => String
    end
  end
end
