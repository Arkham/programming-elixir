defmodule FredBetty do
  def person(pid) do
    receive do
      message ->
        send pid, {self, "#{message} received"}
    end
  end

  def send_messages do
    fred = spawn(FredBetty, :person, [self])
    betty = spawn(FredBetty, :person, [self])

    send betty, "betty"
    send fred, "fred"

    receive_messages(2)
  end

  def receive_messages(n) do
    Enum.each 1..n, fn _ ->
      receive do
        {pid, message} ->
          IO.puts "Pid #{inspect(pid)} sent: #{message}"
      end
    end
  end

  def run do
    FredBetty.send_messages
  end
end
