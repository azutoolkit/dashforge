module JoobQ  
  QUEUES = {
    "Email" => JoobQ::Queue(EmailJob).new("Email", 300),
    "Fail"  => JoobQ::Queue(FailJob).new("Fail", 300),
    "Test"  => JoobQ::Queue(TestJob).new("Test", 300),
  }
end
