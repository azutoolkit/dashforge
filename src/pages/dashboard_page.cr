module Dashboard
  struct Dashboard
    include Azu::Html
    getter joobq = JoobQ.statistics

    def html
      render "dashboard/index.jinja", {
        "busy" => BusySpark.new.content,
        "latency" => LatencySpark.new.content,
        "counts" => counts[:busy], 
        "processing_chart_data" => { data: processing }.to_json,
        "processing_status" => ProcessingStatusSpark.new.content,
        "queue_table" => QueueTableSpark.new.content
      }
    end

    private def counts
      joobq.totals
    end

    private def processing
      data = joobq.range("processing", 30.minutes.ago.to_unix_ms).not_nil!.map do |item|
        ts, value = item.as(Array)
        {t: Time.unix_ms(ts.as(Int64)).to_rfc3339, y: value.as(String).to_i}
      end

      [{ label: "Processing", data: data}]
    end
  end
end