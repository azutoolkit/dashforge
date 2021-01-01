module JoobqGui
  struct Jobs::ShowPage
    include Response::Html

    def initialize(@job : JoobQ::Job)
    end

    def html
      render "jobs/show.jinja", {job_id: @job.jid.to_s}
    end
  end
end
