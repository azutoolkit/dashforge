struct TestJob
  include JoobQ::Job

  property x : Int32
  @retries = 3
  @queue = "queue:Test"

  def self.perform(x : Int32)
    new(x).perform
  end

  def initialize(@x : Int32)
  end

  def perform
  end
end
