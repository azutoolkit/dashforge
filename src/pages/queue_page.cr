module Queues
  struct Index
    include Azu::Html
    getter joobq = JoobQ.statistics
    getter name : String

    def initialize(@name : String)
    end

    def html
      render "queues/index.jinja", {
        "queue"         => joobq.queue(@name),
        "jobs_spark"    => JobsCounter.new(name).render,
        "errors_spark"  => ErrorsCounter.new(name).render,
        "latency_spark" => DurationCounter.new(name).render,
      }
    end
  end
end
