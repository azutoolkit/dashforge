module Dashboard
  class LatencySpark < Azu::SparkView
    include Azu::Html
    getter joobq = JoobQ.statistics

    TEMPLATE = "dashboard/partials/count.jinja.html"

    def mount
      every(1.seconds) { refresh }
    end
  
    def component
      html
    end
  
    def html
      render TEMPLATE, { 
        "title" => "Latency",
        "subtitle" => "Job processing duration",
        "unit" => "ms",
        "total" => latency, 
        "description" => "Jobs currently busy."
      }
    end

    private def latency
      joobq.range(
        "processing", 
        since: 5.seconds.ago.to_unix_ms, 
        to: 1.second.from_now.to_unix_ms, 
        aggr: "avg", 
        count: 1,
        group: 10000
      ).first.as(Array).last
    rescue e
      0
    end
  end
end