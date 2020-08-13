module Queues
  struct Completed
    include Azu::Html

    def html
      render "queues/completed.jinja", {} of String => String
    end
  end
end