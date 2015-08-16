defmodule DefaultParams do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end

  def func_with_default(p1, p2 \\ 123)

  def func_with_default(p1, p2) do
    IO.inspect [p1, p2]
  end

  def func_with_default(p1, 99) do
    IO.puts "you said 99"
  end
end

DefaultParams.func("a", "b")
DefaultParams.func("a", "b", "c")
DefaultParams.func("a", "b", "c", "d")

DefaultParams.func_with_default("a")
