module JoobQ
  QUEUES = {
    "queue:Email" => JoobQ::Queue(EmailJob).new("queue:Email", 5),
    "queue:Fail"  => JoobQ::Queue(FailJob).new("queue:Fail", 5),
    "queue:Test"  => JoobQ::Queue(TestJob).new("queue:Test", 5),
  }

  scheduler.register do
    cron "5 4 * * *" { TestJob.perform(1) }
    delay TestJob.new(1), for: 1.minute
    every 1.hour, EmailJob
  end
end
