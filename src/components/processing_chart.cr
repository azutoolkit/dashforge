class ProcessingChart < Azu::SparkView
  include Components
  getter joobq = JoobQ.statistics

  def mount
    every(1.seconds) { refresh }
  end

  def component
    <<-HTML
    <div class="card-footer pd-y-15 pd-x-20">
      <div class="row row-sm">
      #{queue_progress("Total", "primary", counts[:total], 100)}
      #{queue_progress("Completed", "success", counts[:completed], counts[:completed_percent])}
      #{queue_progress("Retry", "info", counts[:retry], counts[:retry_percent])}
      #{queue_progress("Dead", "danger", counts[:dead], counts[:dead_percent])}
      </div>
    </div>
    HTML
  end

  private def counts
    joobq.totals
  end
end
