module Queues
  class ErrorsSpark < Azu::SparkView
    include Azu::Html
    getter joobq = JoobQ.statistics
    getter start_time : Int64

    TEMPLATE = "queues/partials/errors.jinja.html"
    
    def initialize(@name : String)
      @start_time = 0
    end
    
    def mount
      every(5.seconds) { refresh }
    end
  
    def render(io)
      io << html
    end
  
    def html
      render TEMPLATE, {
        "errors_count" => total_errors,
        "errors_list" => errors_series.join(",")
      }
    end

    private def total_errors
      joobq.range("#{@name}:error", count: 1, group: 900000).first.as(Array).last
    end

    private def errors_series
      joobq.range("#{@name}:error", start_time, count: 38).map do |item|
        item.as(Array).last.as(String)
      end
    end
  end
end