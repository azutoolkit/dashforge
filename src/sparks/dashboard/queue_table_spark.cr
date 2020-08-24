module Dashboard
  class QueueTableSpark < Azu::SparkView
    include Azu::Html
    getter joobq = JoobQ.statistics
    
    TEMPLATE = "queues/partials/queue_table.jinja.html"

    def mount
      every(1.seconds) { refresh }
    end
  
    def render(io)
      io << html
    end
  
    def html
      render TEMPLATE, {"queues" => joobq.queues_details }
    end
  end
end