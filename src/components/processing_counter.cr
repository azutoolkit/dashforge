class ProcessingCounter
  include Azu::Component
  getter joobq = JoobQ.statistics

  def mount
    every(1.seconds) { refresh }
  end

  def content
    div class: "card" do
      div class: "card-header" do
        h6 "Processing", class: "mg-b-0"
      end

      div class: "card-body tx-center" do
        h4 class: "tx-normal tx-rubik tx-40 tx-spacing--1 mg-b-0" do
          text processing_count
          small " jobs"
        end

        div "Jobs currently busy", class: "divider-text"
      end
    end
  end

  private def processing_count
    result = joobq.range("processing", 1.second.ago.to_unix_ms, group: 1000, count: 1).not_nil!.first
    result.as(Array).last
  rescue e
    0
  end
end
