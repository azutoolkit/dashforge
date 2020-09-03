module Queues
  struct Index
    include Azu::Html
    getter joobq = JoobQ.statistics
    getter name : String

    def initialize(@name : String)
    end

    def html
      render "queues/index.jinja", {
        "queue" => joobq.queue(@name),
        "jobs_spark" => Queues::JobsSpark.new(name).content,
        "errors_spark" => Queues::ErrorsSpark.new(name).content,
        "latency_spark" => Queues::LatencySpark.new(name).content
      }
    end
  end
end
