module JoobQ  
  QUEUES = {
    "Email" => JoobQ::Queue(EmailJob).new("Email", 3),
    "Fail"  => JoobQ::Queue(FailJob).new("Fail", 2),
    "Test"  => JoobQ::Queue(TestJob).new("Test", 1),
  }
end
