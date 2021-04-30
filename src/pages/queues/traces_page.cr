module DashForge
  struct Queues::TracesPage
    include Response
    include Templates::Renderable
    
    getter template = "queues/traces.jinja"
    getter joobq = JoobQ.statistics
    @name : String

    def initialize(@name : String)
    end

    def render
      render template, {
        "name"             => name,
        "jobs_table_spark" => JobsTable.mount(name: name),
      }
    end

    def name
      @name.capitalize
    end
  end
end
