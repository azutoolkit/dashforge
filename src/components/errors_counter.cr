class ErrorsCounter
  include Azu::Component
  include Commons
  getter joobq = JoobQ.statistics

  def initialize(@name : String)
  end

  def mount
    every(10.seconds) { refresh }
  end

  def content
    card_counter(
      title: "Errors",
      name: "errors",
      color: "danger",
      unit: "errors",
      count: total_errors.to_s,
      series: errors_series.to_s).to_s
  end

  private def total_errors
    since = 5.seconds.ago.to_unix_ms
    to = 1.second.from_now.to_unix_ms
    joobq.range("#{@name}:error", since: since, to: to, count: 1, group: 1000).first.as(Array).last
  rescue
    0
  end

  private def errors_series
    since = 15.minutes.ago.to_unix_ms
    to = 1.second.from_now.to_unix_ms
    joobq.range("#{@name}:error", since: since, to: to, count: 39, group: 1000).map do |item|
      item.as(Array).last.as(String)
    end.join(",")
  rescue
    0
  end
end
