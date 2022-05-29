class LatencyCounter
  include Azu::Component
  getter joobq = JoobQ.statistics

  def mount
    every(10.seconds) { refresh }
  end

  def unmount
  end

  def on_event(name, data)
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
        div "Jobs duration busy", class: "divider-text"
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
      group: 1000,
    ).first.as(Array).last.as(String).to_f.format(decimal_places: 2)
  rescue e
    0
  end
end
