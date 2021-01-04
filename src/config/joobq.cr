module JoobQ
  QUEUES = {
    "Email" => JoobQ::Queue(EmailJob).new("Email", 25),
    "Fail"  => JoobQ::Queue(FailJob).new("Fail", 25),
    "Test"  => JoobQ::Queue(TestJob).new("Test", 25),
  }
end
