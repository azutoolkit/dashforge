struct FailJob
  include JoobQ::Job
  @queue = "Fail"
  @retries = 3

  def initialize
  end

  def perform
    raise Exception.new if rand(10) % 2 == 0
  end
end
