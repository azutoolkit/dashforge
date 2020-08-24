module Queues
  struct Index
    include Azu::Html

    def initialize(@name : String)
    end

    def html
      render "queues/index.jinja", {
        "errors_spark" => Queues::ErrorsSpark.new(@name).to_s(IO::Memory.new).to_s,
        "latency_spark" => Queues::LatencySpark.new(@name).to_s(IO::Memory.new).to_s
      }
    end

    def xml
    end

    def text
      "TEXT"
    end

    def json
      { json: true }.to_json
    end
  end
end
