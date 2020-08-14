module JoobQ
  @@workers_capacity = 300
  QUEUES = {
    "Email" => JoobQ::Queue(EmailJob).new("Email", 2000),
    "Fail"  => JoobQ::Queue(FailJob).new("Fail", 100),
    "Test"  => JoobQ::Queue(TestJob).new("Test", 100),
  }
end