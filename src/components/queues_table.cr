class QueuesTable < Azu::SparkView
  getter joobq = JoobQ.statistics

  def mount
    every(1.seconds) { refresh }
  end

  def component
    <<-HTML
    <div class="card mg-b-10">
      <div class="card-header pd-t-20 d-sm-flex align-items-start justify-content-between bd-b-0 pd-b-0">
        <div>
          <h6 class="mg-b-5">Your Queues</h6>
        </div>
      </div>
      <div class="table-responsive">
        <table class="table table-dashboard mg-b-0">
          <thead>
            <tr>
              <th class="text-dark">Status</th>
              <th class="text-dark">Name</th>
              <th class="text-right text-dark">Jobs</th>
              <th class="text-right text-dark">No. Workers</th>
              <th class="text-right text-dark">Queued Jobs</th>
            </tr>
          </thead>
          <tbody> 
          #{rows}
          </tbody>
        </table>
      </div>
    </div>
    HTML
  end

  def rows
    joobq.queues_details.map do |queue|
      <<-HTML
      <tr>
        <td class="tx-color-03 tx-normal tx-danger">#{queue[:status]}</td>
        <td class="tx-color-03 tx-normal"><a href="/queues/#{queue[:name]}">#{queue[:name]}</a></td>
        <td class="text-right">#{queue[:jobs]}</td>
        <td class="tx-medium text-right">#{queue[:total_workers]}</td>
        <td class="text-right">#{queue[:size]}</td>
      </tr>
      HTML
    end
  end
end
