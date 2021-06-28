require "json"

module DashForge
  struct Jobs::ShowPage
    include Response
    include Templates::Renderable

    getter template = "jobs/show.jinja"
    getter job : JoobQ::Job

    @[Crinja::Attributes]
    record Error,
      queue : String,
      failed_at : Time,
      message : String?,
      cause : String?,
      backtrace : String do
      include Crinja::Object::Auto
      include JSON::Serializable
    end

    def initialize(@job : JoobQ::Job)
    end

    def render
      render template, {
        "job_id"       => job.jid.to_s,
        "retries"      => job.retries,
        "total_errors" => total_errors,
        "expires"      => expires,
        "errors"       => errors,
        "queue_name"   => job.queue,
      }
    end

    private def expires
      (Time.local + @job.expires.seconds).to_rfc2822
    end

    private def total_errors
      JoobQ::REDIS.command ["ZCARD", "Failed:#{job.jid}"]
    end

    private def errors
      result = JoobQ::REDIS.command(["ZRANGE", "Failed:#{job.jid}", "0", "-1"])
      errors = result.as(Array(Redis::RedisValue)).map do |e|
        err = e.as(String)
        Error.from_json err
      end

      errors
    end
  end
end
