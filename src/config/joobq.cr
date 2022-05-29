require "joobq"

JoobQ.configure do
  queue "queue:Email", ENV["EMAIL_QUEUE_WORKERS"].not_nil!.to_i, EmailJob
  queue "queue:Fail", ENV["FAIL_QUEUE_WORKERS"].not_nil!.to_i, FailJob
  queue "queue:Test", ENV["TEST_QUEUE_WORKERS"].not_nil!.to_i, TestJob

  scheduler do
    cron "5 4 * * *" { TestJob.perform(1) }
    delay TestJob.new(1), for: 1.minute
    every 1.hour, EmailJob
  end
end
