module Queues
  struct ShowPage
    include Azu::Html
    getter joobq = JoobQ.statistics
    getter name : String

    def initialize(@name : String)
    end

    def html
      render "queues/index.jinja", {
        "queue"         => joobq.queue(name: name),
        "jobs_spark"    => JobsCounter.mount(name: name),
        "errors_spark"  => ErrorsCounter.mount(name: name),
        "latency_spark" => DurationCounter.mount(name: name),
      }
    end
  end
end
