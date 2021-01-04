module JoobQ
  QUEUES = {
    "Email" => JoobQ::Queue(EmailJob).new("Email", 50),
    "Fail"  => JoobQ::Queue(FailJob).new("Fail", 15),
    "Test"  => JoobQ::Queue(TestJob).new("Test", 35),
  }
end
