module JoobqGui
  class Dashboard::IndexPage
    include Response::Html
    getter joobq = JoobQ.statistics

    TEMPLATE = "dashboard/index.jinja"

    def html
      render TEMPLATE, {
        "busy"                  => ProcessingCounter.mount,
        "latency"               => LatencyCounter.mount,
        "counts"                => counts[:busy],
        "processing_chart_data" => {data: processing}.to_json,
        "processing_status"     => ProcessingChart.mount,
        "queue_table"           => QueuesTable.mount,
      }
    end

    private def counts
      joobq.totals
    end

    private def processing
      data = joobq.range("processing", 1.days.ago.to_unix_ms).not_nil!.map do |item|
        p item
        ts, value = item.as(Array)
        {t: Time.unix_ms(ts.as(Int64)).to_rfc3339, y: value.as(String).to_i}
      end

      [{label: "Processing", data: data}]
    end
  end
end
