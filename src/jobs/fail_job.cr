struct FailJob
  include JoobQ::Job
  @queue = "Fail"
  @retries = 3

  def initialize
  end

  def perform
    raise Exception.new if rand(2) == 1
    sleep rand(5).milliseconds
  end
end
