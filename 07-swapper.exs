defmodule Swapper do
  def swap([]), do: []
  def swap([a, b | tail]), do: [b, a | swap(tail)]
  def swap([_]), do: raise "Can't swap a list with an odd number of elements"
end

IO.inspect Swapper.swap([1,2,3,4,5,6])
IO.inspect Swapper.swap([1,2,3,4,5])
