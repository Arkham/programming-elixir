defmodule FibSolver do
  def fib(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:perform, n, client} ->
        send client, {:answer, n, fib_calc(n), self}
        fib(scheduler)
      {:shutdown} ->
        exit(:normal)
    end
  end

  def fib_calc(0), do: 1
  def fib_calc(1), do: 1
  def fib_calc(n) when n > 0, do: fib_calc(n-1) + fib_calc(n-2)
end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn _ -> spawn(module, func, [self]) end)
    |> schedule_processes(to_calculate, [])
  end

  def schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 1 ->
        [ next | tail ] = queue
        send pid, {:perform, next, self}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        processes = List.delete(processes, pid)

        if length(processes) > 1 do
          schedule_processes(processes, queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [{number, result} | results])
    end
  end
end

# data = [ 37, 37, 37, 37, 37, 37 ]

# Enum.each 1..10, fn num_processes ->
#   {time, result} = :timer.tc(Scheduler, :run, [num_processes, FibSolver, :fib, data])

#   if num_processes == 1 do
#     IO.puts inspect result
#     IO.puts "\n# time(s)"
#   end

#   IO.puts "#{num_processes}: #{time/1_000_000}"
# end

defmodule CatFinder do
  def find(scheduler) do
    send scheduler, {:ready, self}

    receive do
      {:perform, filename, client} ->
        case File.read(filename) do
          {:ok, content} ->
            send client, {:answer, filename, string_count(content, "cat"), self}
          {:error, _ } -> true
        end

        find(scheduler)

      {:shutdown} ->
        exit(:normal)
    end
  end

  def string_count(string, haystack) do
    length(String.split(string, haystack)) - 1
  end
end

# directory = "."
# files = Enum.map(File.ls!(directory), fn(name) -> "#{directory}/#{name}" end)

# Enum.each 1..10, fn num_processes ->
#   {time, results} = :timer.tc(Scheduler, :run, [num_processes, CatFinder, :find, files])

#   if num_processes == 1 do
#     IO.puts inspect results
#     IO.puts "\n# time(s)"
#   end

#   IO.puts "#{num_processes}: #{time/1_000_000}"
# end
