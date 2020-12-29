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
          text processing
          small " jobs"
        end

        div "Jobs currently busy", class:"divider-text"
      end
    end
  end

  private def processing
    joobq.redis.llen("Busy")
  rescue e
    0
  end
end
