module Dashboard
  struct Index
    include Azu::Html
    getter queue : QueueService = QueueService.instance

    def html
      render "dashboard/index.jinja", {
        "counts" => queue.counts,
        "activity_chart" =>  ProcessingSpark.new.to_s(IO::Memory.new).to_s,
        "queue_table" => QueueTableSpark.new.to_s(IO::Memory.new).to_s
      }
    end
  end
end
