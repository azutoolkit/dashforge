module DashForge
  struct Request
    include Request
    getter queue : String
    getter job_id : UUID
  end

  module Jobs::Show
    include Endpoint(Request, ShowPage)
    get "/jobs/:job_id"

    def call : Jobs::ShowPage
      Jobs::ShowPage.new(job.not_nil!)
    end

    def job
      JoobQ::QUEUES[job_request.queue].get_job(job_request.job_id)
    end
  end
end
