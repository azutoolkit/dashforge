struct EmailJob
  include JoobQ::Job

  @queue = "queue:Email"
  @retries = 3

  def initialize
  end

  def perform
    sleep rand(5).milliseconds
  end
end
