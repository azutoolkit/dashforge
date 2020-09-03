module Dashboard
  class ProcessingStatusSpark < Azu::SparkView
    include Azu::Html
    getter joobq = JoobQ.statistics

    TEMPLATE = "partials/processing_status.jinja.html"

    def mount
      every(1.seconds) { refresh }
    end
  
    def component
      html
    end
  
    def html
      render TEMPLATE, { "counts" => counts }
    end

    private def counts
      joobq.totals
    end
  end
end