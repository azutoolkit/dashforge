module DashForge
  struct Scheduler::IndexPage
    include Response
    include Templates::Renderable

    getter scheduler = JoobQ.scheduler
    getter template = "scheduler/index.jinja"

    def render
      render template, {
        "jobs" => jobs,
      }
    end

    def jobs
      scheduler.jobs.map do |name, schedule|
        map_schedule(schedule, name)
      end
    end

    def map_schedule(s : JoobQ::Scheduler::RecurringJobs, interval : String)
      rec_interval = s.interval
      job = s.job
      {
        "class_name" => interval,
        "queue"      => job.queue,
        "expires"    => job.expires,
        "retries"    => job.retries,
        "interval"   => s.interval.to_s,
        "next_run"   => (Time.local).to_rfc2822,
        "last_run"   => Time.local.to_rfc2822,
      }
    end

    def map_schedule(cron : CronParser, interval : String)
      rec_interval = interval

      {
        "class_name" => cron.class.to_s,
        "queue"      => "",
        "expires"    => "",
        "retries"    => "",
        "interval"   => interval,
        "next_run"   => cron.next.to_rfc2822,
        "last_run"   => cron.last.to_rfc2822,
      }
    end
  end
end
