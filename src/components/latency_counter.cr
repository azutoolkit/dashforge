class LatencyCounter
  include Azu::Component
  getter joobq = JoobQ.statistics

  def mount
    every(1.seconds) { refresh }
  end

  def content
    div class: "card" do
      div class: "card-header" do
        h6 "Latency", class: "mg-b-0"
      end
      div class: "card-body tx-center" do
        h4 class: "tx-normal tx-rubik tx-40 tx-spacing--1 mg-b-0" do
          text "#{latency} "
          small "ms"
        end
        para "Jobs duration in ms.", class: "tx-12 tx-uppercase tx-semibold tx-spacing-1 tx-color-02"
        para "Jobs duration busy.", class: "tx-12 tx-color-03 mg-b-0"
      end
    end
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
