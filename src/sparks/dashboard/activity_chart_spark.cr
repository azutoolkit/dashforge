module Dashboard
  class ActivityChartSpark < Azu::SparkView
    include Azu::Html
    getter queue : QueueService = QueueService.instance

    TEMPLATE = "dashboard/partials/current_jobs_status.jinja.html"

    def mount
      every(3.seconds) { refresh }
    end
  
    def render(io)
      io << html
    end
  
    def html
      render TEMPLATE, {"counts" => queue.counts}
    end
  end
end