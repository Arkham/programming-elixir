defmodule Chain do
  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self, fn (_, next_pid) ->
      spawn(Chain, :counter, [next_pid])
    end

    send last, 0

    receive do
      n ->
        "The result was #{n}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end
