defmodule Parallel do
  import :timer, only: [sleep: 1]

  def pmap(collection, fun) do
    me = self

    collection
    |> Enum.map(fn (elem) ->
         spawn_link fn ->
           sleep round(:random.uniform * 100)
           send me, { self, fun.(elem) }
         end
       end)
    |> Enum.map(fn (pid) ->
         receive do { ^pid, result } -> result end
       end)
  end
end

result = Parallel.pmap(10..200, &(&1 * &1))
IO.puts inspect result
IO.puts inspect List.last(result)
