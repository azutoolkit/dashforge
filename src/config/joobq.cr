module JoobQ
  QUEUES = {
    "Email" => JoobQ::Queue(EmailJob).new("Email", 1),
    "Fail"  => JoobQ::Queue(FailJob).new("Fail", 1),
    "Test"  => JoobQ::Queue(TestJob).new("Test", 1),
  }
end
