class JobsService
  getter joobq = JoobQ.statistics

  def self.size
    joobq.queues.reduce(0) { |acc, (_, q)| acc += q.size }
  end

  def failed(key)
    joobq.failed(key).size
  end

  def running(name)
    joobq.query(
      from: 3.hour.ago.to_unix_ms,
      to: Time.local.to_unix_ms,
      filters: "name=#{name}",
      aggr: "count",
      group_by: 1000,
      count: 100)
  end
end
