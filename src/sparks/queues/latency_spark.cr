module Queues
  class LatencySpark < Azu::SparkView
    include Azu::Html
    getter queue : QueueService = QueueService.instance
    
    TEMPLATE = "queues/partials/latency.jinja.html"
    
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
        "average_latency" => average_latency,
        "latency_overtime" => latency_overtime
      }
    end

    private def average_latency
      # total = latency.reduce(0) { |acc, n| acc + n}
      # total/latency.size
    end

    private def latency_overtime
      # latency.join(",")
    end

    private def latency
      # queue.latency(["name=#{@name}"], 1.day.ago, 100)
      #   .map { |item| item.as(Array).last.as(String).to_i }
    end
  end
end