defmodule Fib do
  def of(0), do: 0
  def of(1), do: 1
  def of(n) when n > 0, do: Fib.of(n - 1) + Fib.of(n - 2)
end

IO.puts "Start the task"
worker = Task.async(Fib, :of, [20])
IO.puts "Do something else"

IO.puts "Wait for the task"
result = Task.await(worker)

IO.puts "The result is #{result}"
