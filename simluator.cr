require "./src/joobq_gui"

iter = 10
count = 10_000_i64
total = iter * count

loop do
  sleep rand(20).seconds
  rand(total).times { |_| FailJob.perform }
  rand(total).times { |_| EmailJob.perform }
  rand(total).times { |i| TestJob.perform(x: i) }
end
