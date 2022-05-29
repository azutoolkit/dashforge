class QueuesTable
  include Azu::Component
  getter joobq = JoobQ.statistics

  def mount
    every(10.seconds) { refresh }
  end

  def unmount
  end

  def on_event(name, data)
  end

  private def queues
    joobq.queues_details
  end

  def content
    div class: "card mg-b-10" do
      div class: "card-header d-flex align-items-center justify-content-between bd-b-0" do
        h6 "Your Queues", class: "mg-b-0"
      end
      div class: "table-responsive" do
        table class: "table table-dashboard mg-b-0" do
          thead do
            tr do
              th "Status", class: "text-dark"
              th "Name", class: "text-dark"
              th "Jobs", class: "text-right text-dark"
              th "No. Workers", class: "text-right text-dark"
              th "Queued Jobs", class: "text-right text-dark"
            end
          end
          tbody do
            queues.map do |queue|
              tr do
                td queue[:status], class: "tx-color-03 tx-normal tx-danger"
                td class: "tx-color-03 tx-normal" do
                  a queue[:name], href: "/queues/#{queue[:name]}"
                end
                td queue[:jobs], class: "text-right"
                td queue[:total_workers].to_s, class: "tx-medium text-right"
                td queue[:size].to_s, class: "text-right"
              end
            end
          end
        end
      end
    end
  end
end
