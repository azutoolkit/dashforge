module JoobqGui
  struct JobRequest
    include Request

    getter queue : String
    getter job_id : UUID
  end

  class Jobs::Show
    include Endpoint(JobRequest, Jobs::ShowPage)

    def call : Jobs::ShowPage
      Jobs::ShowPage.new(job.not_nil!)
    end

    def job
      JoobQ::QUEUES[job_request.queue][job_request.job_id]?
    end
  end
end
