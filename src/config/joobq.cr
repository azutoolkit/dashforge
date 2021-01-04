module JoobQ
  QUEUES = {
    "Email" => JoobQ::Queue(EmailJob).new("queue:Email", 50),
    "Fail"  => JoobQ::Queue(FailJob).new("queue:Fail", 15),
    "Test"  => JoobQ::Queue(TestJob).new("queue:Test", 35),
  }
end
