defmodule IntegerSum do
  def of(1), do: 1
  def of(n) when n > 1, do: n + sum(n-1)
end
