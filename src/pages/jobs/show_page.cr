module DashForge
  struct Jobs::ShowPage
    include Response::Html
    getter template = "jobs/show.jinja"

    def initialize(@job : JoobQ::Job)
    end

    def html
      render template, {job_id: @job.jid.to_s}
    end
  end
end
