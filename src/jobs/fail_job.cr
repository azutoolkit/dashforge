struct FailJob
  include JoobQ::Job
  @queue = "Fail"
  @retries = 3

  def initialize
  end

  def perform
    raise Exception.new
  end
end
