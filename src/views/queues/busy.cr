module Queues
  struct Busy
    include Azu::Html

    def html
      render "queues/busy.jinja", {} of String => String
    end
  end
end
