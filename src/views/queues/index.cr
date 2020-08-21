module Queues
  struct Index
    include Azu::Html

    def initialize(@name : String)
    end

    def html
      p @name
    end

    def xml
    end

    def text
    end

    def json
    end
  end
end
