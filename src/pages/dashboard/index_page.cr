module DashForge
  class Dashboard::IndexPage
    include Response
    include Templates::Renderable
    TEMPLATE = "dashboard/index.jinja"
    
    getter joobq = JoobQ.statistics

    def render
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
      [{label: "Processing", data: data}]
    end

    private def data
      joobq.range("processing", 1.days.ago.to_unix_ms, group: 5000, count: 100).not_nil!.map do |item|
        ts, value = item.as(Array)
        
        {
          t: Time.unix_ms(ts.as(Int64)).to_rfc3339, 
          y: value.as(String).to_i
        }
      end
    end
  end
end
