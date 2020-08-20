module Queues
  struct Failed
    include Azu::Html

    def html
      render "queues/failed.jinja", {} of String => String
    end
  end
end
