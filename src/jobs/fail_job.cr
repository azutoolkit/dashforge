struct FailJob
  include JoobQ::Job
  @queue = "Fail"
  @retries = 3

  def initialize
  end

  def perform
    raise Exception.new if rand(9) == 3
    sleep rand(5).milliseconds
  end
end
