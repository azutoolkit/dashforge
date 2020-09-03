module Dashboard
  class QueueTableSpark < Azu::SparkView
    include Azu::Html
    getter joobq = JoobQ.statistics
    
    TEMPLATE = "partials/queue_table.jinja.html"

    def mount
      every(1.seconds) { refresh }
    end
  
    def component
      html
    end
  
    def html
      render TEMPLATE, {"queues" => joobq.queues_details }
    end
  end
end