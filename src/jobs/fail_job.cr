struct FailJob
  include JoobQ::Job
  @queue = "queue:Fail"
  @retries = 3

  def initialize
  end

  def perform
    raise Exception.new if rand(9) % 3 == 1
  end
end
