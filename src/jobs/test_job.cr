struct TestJob
  include JoobQ::Job

  property x : Int32
  @retries = 3
  @queue = "Test"

  def initialize(@x : Int32)
  end

  def perform
    sleep rand(2).milliseconds
  end
end