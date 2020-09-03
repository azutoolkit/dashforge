class JobsCounter < Azu::SparkView
  include Components
  getter joobq = JoobQ.statistics

  def initialize(@name : String)
    super()
  end

  def mount
    every(5.seconds) { refresh }
  end

  def component
    card_counter("Jobs Per Second", "j/s", "secondary", "requests", total_jobs.to_s, jobs_series.to_s).to_s
  end

  private def total_jobs
    since = 1.seconds.ago.to_unix_ms
    to = 1.second.from_now.to_unix_ms
    joobq.range("#{@name}:success", since: since, to: to, count: 1, group: 1000).first.as(Array).last
  rescue
    0
  end

  private def jobs_series
    since = 1.minute.ago.to_unix_ms
    to = 1.second.from_now.to_unix_ms

    joobq.range("#{@name}:success", since: since, to: to, count: 39, group: 1000).map do |item|
      item.as(Array).last.as(String)
    end.join(",")
  rescue
    0
  end
end
