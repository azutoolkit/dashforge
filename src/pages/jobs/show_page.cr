module Jobs
  struct ShowPage
    include Azu::Html

    def html
      render "jobs/show.jinja", {} of String => String
    end
  end
end
