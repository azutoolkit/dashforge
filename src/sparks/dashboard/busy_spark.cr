module Dashboard
  class BusySpark < Azu::SparkView
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
        "title" => "Processing",
        "subtitle" => "Jobs currently busy.",
        "unit" => "jobs",
        "total" => processing, 
        "description" => "Jobs currently busy."
      }
    end

    private def processing
      joobq.redis.llen("Busy")
    rescue e
      0
    end
  end
end