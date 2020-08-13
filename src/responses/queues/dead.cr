module Queues
  struct Dead
    include Azu::Html

    def html
      render "queues/dead.jinja", {} of String => String
    end
  end
end