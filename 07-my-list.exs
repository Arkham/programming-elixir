defmodule MyList do
  def len([]), do: 0
  def len([_head|tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head | tail]), do: [head*head | square(tail)]

  def add_1([]), do: []
  def add_1([head | tail]), do: [head+1 | add_1(tail)]

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def sum(list), do: _sum(list, 0)
  defp _sum([], total), do: total
  defp _sum([head | tail], total), do: _sum(tail, head + total)

  def easy_sum([]), do: 0
  def easy_sum([head | tail]), do: head + easy_sum(tail)

  def reduce([], value, _fun), do: value
  def reduce([head | tail], value, fun), do: reduce(tail, fun.(head, value), fun)

  def mapsum(list, fun), do: sum(map(list, fun))

  def max([head | tail]), do: reduce(tail, head, &_maximum/2)
  def _maximum(first, second) when first > second, do: first
  def _maximum(first, second) when first <= second, do: second

  def caesar(list, n), do: map(list, fn (el) -> _wrap(el + n) end)
  def _wrap(char) when char > ?z, do: ?a + rem(rem(char, ?a), 26)
  def _wrap(char), do: char

  def span(from, to) when from > to, do: raise "from has to greater than to"
  def span(from, to), do: _span(from, to, [])
  defp _span(from, to, result) when from == to, do: result
  defp _span(from, to, result), do: _span(from + 1, to, [from | result])
end

p = fn value ->
  IO.inspect(value)
end

p.(MyList.len([1, 2, 3]))
p.(MyList.square([4, 5, 6]))
p.(MyList.add_1([4, 5, 6]))
p.(MyList.map([1, 2, 3], &(&1 > 2)))
p.(MyList.map([1, 2, 3], &(&1 * &1 * &1)))
p.(MyList.sum([4, 5, 6]))
p.(MyList.easy_sum([4, 5, 6]))
p.(MyList.reduce([4, 5, 6], 1, &(&1 * &2)))
p.(MyList.mapsum([1, 2, 3], &(&1 * &1)))
p.(MyList.max([4, 5, 6, 3, 2, 1]))
p.(MyList.caesar('ryvkve', 13))
p.(MyList.span(150, 163))
