class QueueService
  getter joobq = JoobQ.statistics

  INSTANCE = new

  def self.instance
    INSTANCE
  end

  def counts
    joobq.count_stats
  end

  def workers
    queque_workers_count.reduce(0) { |acc, w| acc += w }
  end

  def total_jobs
    joobq.queues.reduce(0) { |acc, (_, q)| acc += q.size }
  end

  def size
    result = Hash(String, NamedTuple(percent: Int32, count: Int32)).new
    total = total_jobs

    joobq.queues.map do |name, q|
      percent = q.size.zero? ? 0 : ((q.size/total) * 100).to_i
      result[q.name] = {percent: percent, count: q.size.to_i}
    end

    result
  end

  def processing(since, count = 100)
    source = [] of NamedTuple(label: String, data: Array(NamedTuple(t: String, y: Int32)))

    joobq.queues.keys.sort.map do |name|
      data = processing_count(name, since, count).not_nil!.map do |item|
        ts, value = item.as(Array)
        {t: Time.unix_ms(ts.as(Int64)).to_rfc3339, y: value.as(String).to_i}
      end
      source << { label: name, data: data}
    end

    source
  end

  def processing_count(name, since, count = 100)
    joobq.query(
      from: since.to_unix_ms,
      to: Time.local.to_unix_ms,
      filters: "name=#{name}",
      aggr: "count",
      group_by: 1000,
      count: count)
  end

  def latency(name : String)
    joobq.query(
      from: 1.hour.ago.to_unix_ms,
      to: Time.local.to_unix_ms,
      filters: "name=#{name}",
      aggr: "avg",
      group_by: 1,
      count: 1).first.as(Array).last.as(String).to_f
  end

  def all
    joobq.queues
  end

  def queues
   joobq.queues_details
  end

  def workers_count
    all.map do |_, q|
      q.total_workers
    end
  end
end
