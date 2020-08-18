require "./src/joobq_gui"

iter = 10
count = 10_000_i64
total = iter * count

total.times { |_| FailJob.perform }
total.times { |_| EmailJob.perform }
total.times { |i| TestJob.perform(x: i) }
  
