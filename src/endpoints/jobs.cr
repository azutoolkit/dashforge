module DashForge
  struct JobRequest
    include Request
    getter queue : String
    getter job_id : UUID
  end

  class Jobs::Show
    include Endpoint(JobRequest, ShowPage)
    get "/queues/:queue/jobs/:job_id"

    def call : Jobs::ShowPage
      Jobs::ShowPage.new(job.not_nil!)
    end

    def job
      JoobQ.queues[job_request.queue].get_job(job_request.job_id)
    end
  end
end
