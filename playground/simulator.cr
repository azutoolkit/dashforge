require "joobq"
require "../src/jobs/**"
require "../src/config/**"

iterator = ->{ rand(10) * 1000 }

loop do
  spawn do
    iterator.call.times do |i|
      EmailJob.perform
    end
  end

  spawn do
    iterator.call.times do |i|
      FailJob.perform
    end
  end

  spawn do
    iterator.call.times do |i|
      TestJob.perform(x: i)
    end
  end

  sleep rand(30)
end
sleep
