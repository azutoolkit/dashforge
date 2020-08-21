module Queues
  class ErrorsSpark < Azu::SparkView
    include Azu::Html
    getter queue : QueueService = QueueService.instance
    
    TEMPLATE = "queues/partials/errors.jinja.html"
    
    def initialize(@name : String)
    end
    
    def mount
      every(1.seconds) { refresh }
    end
  
    def render(io)
      io << html
    end
  
    def html
      render TEMPLATE, {
        "errors_count" => errors.size,
        "errors_list" => errors
      }
    end

    def errors
      queue.processing_count("status=errors", 10.minutes.ago, 100)
    end
  end
end