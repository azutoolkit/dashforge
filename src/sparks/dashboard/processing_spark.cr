module Dashboard
  class ProcessingSpark < Azu::SparkView
    include Azu::Html
    getter queue : QueueService = QueueService.instance

    TEMPLATE = "dashboard/partials/processing.jinja.html"

    def mount
      every(3.seconds) { refresh }
    end
  
    def render(io)
      io << html
    end
  
    def html
      render TEMPLATE, { "counts" => queue.counts, "chart" =>  { data: queue.processing }.to_json }
    end
  end
end