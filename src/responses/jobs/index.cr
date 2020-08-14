module Jobs
  struct Index
    include Azu::Html

    def html
      render "jobs/index.jinja", {} of String => String
    end
  end
end