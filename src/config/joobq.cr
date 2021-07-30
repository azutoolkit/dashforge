require "joobq"

JoobQ.configure do
  queue "queue:Email", 1, EmailJob
  queue "queue:Fail", 1, FailJob
  queue "queue:Test", 1, TestJob

  scheduler do
    cron "5 4 * * *" { TestJob.perform(1) }
    delay TestJob.new(1), for: 1.minute
    every 1.hour, EmailJob
  end
end
