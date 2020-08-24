class ChartsChannel < Azu::Channel
  getter joobq = JoobQ.statistics
  
  def on_connect
    spawn do
      loop do
        sleep 5.seconds
        data = { data: processing }.to_json
        socket.send data
      end
    end
  end

  private def processing
    data = joobq.range("processing", 30.minutes.ago.to_unix_ms).not_nil!.map do |item|
      ts, value = item.as(Array)
      {t: Time.unix_ms(ts.as(Int64)).to_rfc3339, y: value.as(String).to_i}
    end

    [{ label: "Processing", data: data}]
  end

  def on_message(message); end

  def on_binary(binary); end

  def on_ping(message); end

  def on_pong(message); end

  def on_close(code, message); end
end