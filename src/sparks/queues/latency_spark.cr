module Queues
  class LatencySpark < Azu::SparkView
    include Azu::Html
    getter joobq = JoobQ.statistics
    getter start_time : Int64
    
    TEMPLATE = "queues/partials/latency.jinja.html"

    def initialize(@name : String)
      @start_time = 5.hours.ago.to_unix_ms
    end
    
    def mount
      every(1.seconds) { refresh }
    end
  
    def render(io)
      io << html
    end
  
    def html
      render TEMPLATE, {
        "average_latency" => average_latency,
        "latency_overtime" => latency_overtime
      }
    end

    private def average_latency
      joobq.range("#{@name}:success", since: start_time, count: 1, aggr: "avg")
        .first.as(Array)
        .last
        .as(String).to_f64.round(2)
    end

    private def latency_overtime
      joobq.range("#{@name}:success", start_time, aggr: "avg", count: 38).map do |item|
        (item.as(Array).last.as(String).to_f64).round(2)
      end.join(",")
    end
  end
end