require "joobq"
require "../src/jobs/**"
require "../src/config/**"

iter = 10
count = 10_000
total = iter * count

spawn do
  total.times do |i|
    EmailJob.perform
  end

  sleep rand(10)
end

spawn do
  total.times do |i|
    FailJob.perform
  end

  sleep rand(10)
end

spawn do
  total.times do |i|
    TestJob.perform(x: i)
  end

  sleep rand(10)
end

sleep
