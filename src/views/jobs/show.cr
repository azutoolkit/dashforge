module Jobs
  struct Show
    include Azu::Html

    def html
      render "jobs/show.jinja", {} of String => String
    end
  end
end
