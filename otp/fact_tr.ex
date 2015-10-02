defmodule TailRecursive do
  def factorial(n), do: _fact(n, 1)

  defp _fact(1, result), do: result
  defp _fact(n, result) when n > 0, do: _fact(n-1, n * result)
end
