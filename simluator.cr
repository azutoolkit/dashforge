require "./src/joobq_gui"

spawn do
  loop do
    sleep rand(3).seconds

    rand(50).times { |_| FailJob.perform }
    rand(200).times { |_| EmailJob.perform }
    rand(1000).times { |i| TestJob.perform(x: i) }
  end
end

sleep