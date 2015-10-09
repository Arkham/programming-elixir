# The ticker process in this chapter is a central server that sends events to
# registered clients. Reimplement this as a ring of clients. A client sends a
# tick to the next client in the ring. After 2 seconds, that client sends a tick
# to its next client.

# When thinking about how to add clients to the ring, remember to deal with the
# case where a client’s receive loop times out just as you’re adding a new
# process. What does this say about who has to be responsible for updating the
# links?

defmodule RingMaster do
  @name :ring_master

  def run do
    pid = spawn(__MODULE__, :loop, [])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def loop do
    IO.puts "# Master ready..."

    receive do
      {:register, pid} ->
        IO.puts "# Registered #{inspect pid}"

        send pid, {:set_next, pid}
        IO.puts "# First is #{inspect pid}"
        IO.puts "# Last is #{inspect pid}"

        send pid, {:tick, 1}
        IO.puts "-> Tick 1 sent"

        loop(pid, pid)
    end
  end

  def loop(first, last) do
    receive do
      {:register, pid} ->
        IO.puts "# Registered #{inspect pid}"

        send last, {:set_next, pid}
        send pid, {:set_next, first}
        IO.puts "# First is #{inspect first}"
        IO.puts "# Last is #{inspect pid}"

        loop(first, pid)
    end
  end
end

defmodule RingClient do
  @interval 2000

  def run do
    pid = spawn(__MODULE__, :loop, [])
    RingMaster.register(pid)
  end

  def loop do
    receive do
      {:set_next, pid} ->
        IO.puts "# Next is #{inspect pid}"
        loop(pid)
    end
  end

  def loop(next) do
    receive do
      {:tick, num} ->
        IO.puts "<- Tick #{num} received"
        loop(next, num, true)
    end
  end

  def loop(next, num, send_message) do
    receive do
      {:tick, num} ->
        IO.puts "<- Tick #{num} received"
        loop(next, num, true)
      {:set_next, pid} ->
        IO.puts "# Next is #{inspect pid}"
        loop(pid, num, send_message)
    after @interval ->
      case send_message do
        false ->
          loop(next, num, send_message)
        true ->
          next_num = num + 1
          send next, {:tick, next_num}
          IO.puts "-> Tick #{next_num} sent"
          loop(next, next_num, false)
      end
    end
  end
end
