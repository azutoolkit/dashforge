module Dashboard
  struct Index
    include Azu::Html
    getter queue : QueueService = QueueService.instance

    def html
      render "dashboard/index.jinja", {
        "counts" => queue.counts,
        "processing_chart_data" => { data: queue.processing( ["stats=stats"], 10.minutes.ago) }.to_json,
        "processing_status" => ProcessingStatusSpark.new.to_s(IO::Memory.new).to_s,
        "queue_table" => QueueTableSpark.new.to_s(IO::Memory.new).to_s
      }
    end
  end
end
