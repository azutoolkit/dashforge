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

  def processing
    source = [] of NamedTuple(name: String, label: Array(String), data: Array(Int32))

    joobq.queues.keys.sort.map do |name|
      label = [] of String
      data = [] of Int32

      processing_count(name).not_nil!.each do |item|
        ts, value = item.as(Array)
        label << Time.unix_ms(ts.as(Int64)).to_rfc3339
        data << value.as(String).to_i
      end

      source << {name: name, label: label, data: data}
    end

    source
  end

  def processing_count(name)
    joobq.query(
      from: 3.hour.ago.to_unix_ms,
      to: Time.local.to_unix_ms,
      filters: "name=#{name}",
      aggr: "count",
      group_by: 1000,
      count: 100)
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
