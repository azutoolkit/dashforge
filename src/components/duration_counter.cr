class DurationCounter 
  include Azu::Component
  include Commons

  getter joobq = JoobQ.statistics

  def initialize(@name : String)
  end

  def mount
    every(3.seconds) { refresh }
  end

  def content
    card_counter("Duration", "ms", "info", "latency", average_latency.to_s, latency_overtime.to_s).to_s
  end

  private def average_latency
    since = 5.seconds.ago.to_unix_ms
    to = 1.second.from_now.to_unix_ms
    joobq.range("#{@name}:success", since: since, to: to, count: 1, aggr: "avg", group: 1000)
      .first.as(Array)
      .last
      .as(String).to_f64.round(2)
  rescue
    0
  end

  private def latency_overtime
    since = 5.minutes.ago.to_unix_ms
    to = 1.second.from_now.to_unix_ms
    joobq.range("#{@name}:success", since: since, to: to, aggr: "avg", count: 39, group: 1000).map do |item|
      (item.as(Array).last.as(String).to_f64).round(2)
    end.join(",")
  rescue
    0
  end
end
