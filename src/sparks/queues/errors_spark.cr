module Queues
  class ErrorsSpark < Azu::SparkView
    include Azu::Html
    getter joobq = JoobQ.statistics

    TEMPLATE = "queues/partials/stats_card.jinja.html"
    
    def initialize(@name : String)
      super()
    end
    
    def mount
      every(5.seconds) { refresh }
    end
  
    def render(io)
      io << html
    end
  
    def html
      render TEMPLATE, {
        "title" => "Errors",
        "unit" => "errors",
        "color" => "danger",
        "count" => total_errors,
        "series" => errors_series,
        "sparkline" => "errors",
      }
    end

    private def total_errors
      since = 5.seconds.ago.to_unix_ms
      to = 1.second.from_now.to_unix_ms
      joobq.range("#{@name}:error", since: since, to: to, count: 1, group: 1000).first.as(Array).last
    rescue
      0
    end

    private def errors_series
      since = 15.minutes.ago.to_unix_ms
      to = 1.second.from_now.to_unix_ms
      joobq.range("#{@name}:error", since: since, to: to, count: 35, group: 1000).map do |item|
        item.as(Array).last.as(String)
      end.join(",")
    rescue 
      0
    end
  end
end