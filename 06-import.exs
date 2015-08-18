defmodule Example do
  def func1 do
    IO.puts inspect(List.flatten [1,[2,3],4])
  end

  def func2 do
    import List, only: [flatten: 1]
    IO.puts inspect(flatten [5,[6,7],8])
  end
end

Example.func1
Example.func2
