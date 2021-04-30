module DashForge
  struct Jobs::ShowPage
    include Response
    include Templates::Renderable
    
    getter template = "jobs/show.jinja"

    def initialize(@job : JoobQ::Job)
    end

    def render
      render template, {job_id: @job.jid.to_s}
    end
  end
end
