module DashForge
  struct Queues::TracesPage
    include Response::Html
    getter joobq = JoobQ.statistics
    @name : String

    def initialize(@name : String)
    end

    def html
      render "queues/traces.jinja", {
        "name"             => name,
        "jobs_table_spark" => JobsTable.mount(name: name),
      }
    end

    def name
      @name.capitalize
    end
  end
end
