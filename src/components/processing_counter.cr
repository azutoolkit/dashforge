class ProcessingCounter < Azu::SparkView
  getter joobq = JoobQ.statistics

  def mount
    every(1.seconds) { refresh }
  end

  def component
    <<-HTML
    <div class="card">
      <div class="card-header">
        <h6 class="mg-b-0">Processing</h6>
      </div>
      <div class="card-body tx-center">
        <h4 class="tx-normal tx-rubik tx-40 tx-spacing--1 mg-b-0">#{processing} <small>jobs</small></h4>
        <p class="tx-12 tx-uppercase tx-semibold tx-spacing-1 tx-color-02">Jobs currently busy.</p>
        <p class="tx-12 tx-color-03 mg-b-0">Jobs currently busy.</p>
      </div>
    </div>
    HTML
  end

  private def processing
    joobq.redis.llen("Busy")
  rescue e
    0
  end
end
