defmodule Pipe do
  def run do
    (1..10)
    |> Enum.map(&(&1 * &1))
    |> Enum.filter(&(&1 < 40))
  end
end
