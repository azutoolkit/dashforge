module Queues
  class LatencySpark < Azu::SparkView
    include Azu::Html
    getter joobq = JoobQ.statistics
    
    TEMPLATE = "queues/partials/stats_card.jinja.html"

    def initialize(@name : String)
    end
    
    def mount
      every(1.seconds) { refresh }
    end
  
    def render(io)
      io << html
    end
  
    def html
      render TEMPLATE, {
        "title" => "latency",
        "unit" => "ms",
        "color" => "info",
        "count" => average_latency,
        "series" => latency_overtime,
        "sparkline" => "latency",
      }
    end

    private def average_latency
      since = 5.seconds.ago.to_unix_ms
      to = 1.second.from_now.to_unix_ms
      joobq.range("#{@name}:success", since: since, to: to, count: 1, aggr: "avg", group: 1000)
        .first.as(Array)
        .last
        .as(String).to_f64.round(2)
    rescue
      0
    end

    private def latency_overtime
      since = 15.minutes.ago.to_unix_ms
      to = 1.second.from_now.to_unix_ms
      joobq.range("#{@name}:success", since: since, to: to, aggr: "avg", count: 39, group: 1000).map do |item|
        (item.as(Array).last.as(String).to_f64).round(2)
      end.join(",")
    rescue 
      0
    end
  end
end