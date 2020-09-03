module Components
  def card_counter(name : String, title : String, unit : String, color : String, count : String, series : String)
    <<-HTML
    <div class="card">
      <div class="card-header pd-t-20 pd-b-0 bd-b-0 d-flex justify-content-between">
        <h6 class="lh-5 mg-b-0">#{title}</h6>
      </div>
      <div class="card-body pd-0 pos-relative ht-120">
        <div class="pos-absolute t-10 l-20 z-index-10  m-b-30">
          <div class="d-flex d-lg-block d-xl-flex align-items-end">
            <h3 class="tx-normal tx-rubik mg-b-0 mg-r-5 lh-1 text-{{color}}">#{count} #{unit}</h3>
            <p class="tx-11 tx-color-03 mg-b-0">
              last 5 seconds
            </p>
          </div>
        </div>
        <div style="position: absolute; bottom: 0">
            <span id="errors-sparkline" values="#{series}"></span>
        </div>
      </div>
    </div>
    HTML
  end

  def queue_progress(name, style, total, percent)
    <<-HTML
    <div class="col-6 col-sm-4 col-md-3 col-lg">
      <h4 class="tx-normal tx-rubik mg-b-10 mg-r-5">#{total}</h4>
      <div class="progress ht-2 mg-b-10">
        <div class="progress-bar bg-df-2 bg-#{style}" data-toggle="tooltip" 
          title="#{percent}% of jobs" style="width: #{percent}%" 
          role="progressbar" aria-valuenow="#{percent}" aria-valuemin="0"
          aria-valuemax="100"></div>
      </div>
      <h6 class="tx-uppercase tx-spacing-1 tx-semibold tx-10 tx-color-02 mg-b-2 text-#{style}">#{name} #{percent}%</h6>
    </div>
    HTML
  end
end
