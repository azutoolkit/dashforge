module DashForge
  struct Scheduler::IndexPage
    include Response
    include Templates::Renderable
    
    getter scheduler = JoobQ.scheduler
    getter template = "scheduler/index.jinja"

    def render
      render template, {} of String => Nil
    end

    def jobs
    end
  end
end
