require "./src/joobq_gui"

iter = 10
count = 10_000
total = iter * count

total.times do |i|
  FailJob.perform
  EmailJob.perform
  TestJob.perform(x: i)
end
