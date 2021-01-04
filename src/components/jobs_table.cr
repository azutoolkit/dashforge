class JobsTable
  include Azu::Component

  getter joobq = JoobQ.statistics

  def initialize(@name : String)
  end

  def mount
    every(1.second) { refresh }
  end

  private def jobs
    joobq.list(@name, 0, 30)
  end

  def content
    div class: "card mg-b-10" do
      div class: "table-responsive" do
        table class: "table table-dashboard mg-b-0" do
          thead do
            tr do
              th "Queue", class: "text-dark"
              th "Job Id", class: "text-dark"
              th "Run At", class: "text-dark"
              th "Retries left", class: "text-dark"
              th "Action", class: "text-dark"
            end
          end
          tbody do
            jobs.map do |job|
              tr do
                td job["queue"].as_s, class: "tx-color-03 tx-normal tx-danger"
                td class: "tx-color-03 tx-normal tx-danger" do
                  a job["jid"].as_s, href: "/queues/#{job["queue"]}/jobs/#{job["jid"]}"
                end
                td "", class: "tx-color-03 tx-normal"
                td job["retries"].to_s, class: "tx-medium"
                td "Remove"
              end
            end
          end
        end
      end
    end
  end
end
