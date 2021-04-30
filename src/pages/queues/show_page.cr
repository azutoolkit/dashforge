module DashForge
  struct Queues::ShowPage
    include Response
    include Templates::Renderable
    
    getter template = "queues/index.jinja"
    getter joobq = JoobQ.statistics
    getter name : String

    def initialize(@name : String)
    end

    def render
      render template, {
        "queue"            => joobq.queue(name: name),
        "jobs_spark"       => JobsCounter.mount(name: name),
        "errors_spark"     => ErrorsCounter.mount(name: name),
        "latency_spark"    => DurationCounter.mount(name: name),
        "jobs_table_spark" => JobsTable.mount(name: "Busy"),
      }
    end
  end
end
