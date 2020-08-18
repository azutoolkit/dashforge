class ChartsChannel < Azu::Channel
  getter queue : QueueService = QueueService.instance

  def on_connect
    spawn do
      loop do
        sleep 1.seconds
        data = { data: queue.processing(30.minutes.ago) }.to_json
        socket.send data
      end
    end
  end

  def on_message(message); end

  def on_binary(binary); end

  def on_ping(message); end

  def on_pong(message); end

  def on_close(code, message); end
end