module Dashboard
  struct Index
    include Azu::Html

    def html
      render "dashboard/index.jinja", {} of String => String
    end
  end
end