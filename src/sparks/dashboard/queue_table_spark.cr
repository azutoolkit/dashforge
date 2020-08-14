module Dashboard
  class QueueTableSpark < Azu::SparkView
    include Azu::Html
    getter queue : QueueService = QueueService.instance
    
    TEMPLATE = "queues/partials/queue_table.jinja.html"

    def mount
      every(3.seconds) { refresh }
    end
  
    def render(io)
      io << html
    end
  
    def html
      render TEMPLATE, {"queues" => queue.queues}
    end
  end
end