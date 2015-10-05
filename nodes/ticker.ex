defmodule Ticker do
  @name :ticker
  @interval 2000

  def run do
    pid = spawn(__MODULE__, :round_producer, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def producer(clients, id \\ 0) do
    receive do
      {:register, pid} ->
        IO.puts "# Registered #{inspect pid}"
        producer([pid|clients], id)
    after @interval ->
      IO.puts "-> Tick #{id}"
      Enum.each(clients, fn client ->
        send client, {:tick, id}
      end)
      producer(clients, id + 1)
    end
  end

  def round_producer(clients, id \\ 0) do
    receive do
      {:register, pid} ->
        IO.puts "# Registered #{inspect pid}"
        round_producer(clients ++ [pid], id)
    after @interval ->
      IO.puts "-> Tick #{id}"
      case clients do
        [next|tail] ->
          send next, {:tick, id}
          round_producer(tail ++ [next], id + 1)
        [] ->
          round_producer(clients, id + 1)
      end
    end
  end
end

defmodule Client do
  def run do
    pid = spawn(__MODULE__, :consumer, [])
    Ticker.register(pid)
  end

  def consumer do
    receive do
      {:tick, id} ->
        IO.puts "<- Tick #{id} received"
        consumer
    end
  end
end
