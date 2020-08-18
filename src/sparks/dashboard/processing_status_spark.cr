module Dashboard
  class ProcessingStatusSpark < Azu::SparkView
    include Azu::Html
    getter queue : QueueService = QueueService.instance

    TEMPLATE = "dashboard/partials/processing_status.jinja.html"

    def mount
      every(1.seconds) { refresh }
    end
  
    def render(io)
      io << html
    end
  
    def html
      render TEMPLATE, { "counts" => queue.counts }
    end
  end
end