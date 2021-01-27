module DashForge
  struct Scheduler::IndexPage
    include Response::Html
    getter scheduler = JoobQ.scheduler
    getter template = "scheduler/index.jinja"

    def html
      render template, {} of String => Nil
    end

    def jobs
    end
  end
end
