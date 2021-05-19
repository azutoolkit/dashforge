class ProcessingChart
  include Azu::Component
  getter joobq = JoobQ.statistics

  def mount
    every(1.seconds) { refresh }
  end

  def unmount
  end

  def on_event(name, data)
  end

  def content
    div class: "card-footer pd-y-15 pd-x-20" do
      div class: "row row-sm" do
        queue_progress("Total", "primary", counts[:total], 100)
        queue_progress("Completed", "success", counts[:completed], counts[:completed_percent])
        queue_progress("Retry", "info", counts[:retry], counts[:retry_percent])
        queue_progress("Dead", "danger", counts[:dead], counts[:dead_percent])
      end
    end
  end

  private def counts
    joobq.totals
  end

  private def queue_progress(name, style, total, percent)
    div class: "col-6 col-sm-4 col-md-3 col-lg" do
      h4 "#{total}", class: "tx-normal tx-rubik mg-b-10 mg-r-5"
      div class: "progress ht-2 mg-b-10" do
        div aria_valuemax: "100", aria_valuemin: "0", aria_valuenow: "#{percent}",
          class: "progress-bar bg-df-2 bg-#{style}", data_toggle: "tooltip",
          role: "progressbar", style: "width: #{percent}%", title: "#{percent}% of jobs"
      end
      h6 "#{name} #{percent}%", class: "tx-uppercase tx-spacing-1 tx-semibold tx-10 tx-color-02 mg-b-2 text-#{style}"
    end
  end
end
