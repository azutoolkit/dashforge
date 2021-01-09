module DashForge
  struct Scheduler::IndexPage
    include Response::Html
    getter template = "scheduler/index.jinja"

    def html
      render template, {} of String => Nil
    end
  end
end
