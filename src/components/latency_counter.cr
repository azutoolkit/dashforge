  class LatencyCounter < Azu::SparkView
    getter joobq = JoobQ.statistics

    def mount
      every(1.seconds) { refresh }
    end
  
    def component
      <<-HTML
      <div class="card">
        <div class="card-header">
          <h6 class="mg-b-0">Latency</h6>
        </div>
        <div class="card-body tx-center">
          <h4 class="tx-normal tx-rubik tx-40 tx-spacing--1 mg-b-0">#{latency} <small>ms</small></h4>
          <p class="tx-12 tx-uppercase tx-semibold tx-spacing-1 tx-color-02">Jobs duration in ms.</p>
          <p class="tx-12 tx-color-03 mg-b-0">Jobs duration busy.</p>
        </div>
      </div>
      HTML
    end

    private def latency
      joobq.range(
        "processing", 
        since: 5.seconds.ago.to_unix_ms, 
        to: 1.second.from_now.to_unix_ms, 
        aggr: "avg", 
        count: 1,
        group: 10000
      ).first.as(Array).last
    rescue e
      0
    end
  end