module Queues
  class ErrorsSpark < Azu::SparkView
    include Azu::Html
    getter queue : QueueService = QueueService.instance
    getter joobq = JoobQ.statistics
    
    TEMPLATE = "queues/partials/errors.jinja.html"
    getter start_time : Int64
    getter end_time : Int64

    def initialize(@name : String)
      @start_time = 15.minutes.ago.to_unix_ms
      @end_time = Time.local.to_unix_ms
    end
    
    def mount
      every(5.seconds) { refresh }
    end
  
    def render(io)
      io << html
    end
  
    def html
      p errors_list
      render TEMPLATE, {
        "errors_count" => total_errors,
        "errors_list" => errors_list.join(",")
      }
    end

    private def total_errors
      joobq.query(
        from: start_time,
        to: end_time,
        filters: ["name=Fail","status=error"],
        aggr: "count",
        group_by: 6000,
        count: 1).as(Array(Redis::RedisValue))[0].as(Array(Redis::RedisValue)).last
    end

    private def errors_list
      joobq.query(
        from: start_time,
        to: end_time,
        filters: ["name=Fail","status=error"],
        aggr: "count",
        group_by: 60000,
        count: 100).as(Array(Redis::RedisValue)).map do |item| item.as(Array(Redis::RedisValue)).last end
    end
  end
end