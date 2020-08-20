module Queues
  struct Index
    include Azu::Html

    def html
      render "queues/index.jinja", {} of String => String
    end
  end
end
