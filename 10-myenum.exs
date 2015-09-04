defmodule MyEnum do
  def all?([], _) do
    true
  end

  def all?([head|tail], fun \\ fn x -> x end) do
    if fun.(head) do
      all?(tail, fun)
    else
      false
    end
  end

  def each([], _) do
    :ok
  end

  def each([head|tail], fun) do
    fun.(head)
    each(tail, fun)
  end

  def reverse(list), do: reverse(list, [])
  def reverse([], result), do: result
  def reverse([head|tail], result), do: reverse(tail, [head|result])

  def filter(list, fun), do: filter(list, fun, [])
  def filter([], _fun, result), do: reverse(result)
  def filter([head|tail], fun, result) do
    if fun.(head) do
      filter(tail, fun, [head|result])
    else
      filter(tail, fun, result)
    end
  end

  def split(list, count) when count < 0 do
    { result, list } = split(reverse(list), -count)
    { reverse(list), reverse(result) }
  end
  def split(list, count), do: split(list, count, [])
  def split(list, 0, result), do: { reverse(result), list }
  def split([], _count, result), do: { reverse(result), [] }
  def split([head|tail], count, result), do: split(tail, count - 1, [head|result])

  def take(list, count) when count < 0, do: reverse(take(reverse(list), -count))
  def take(list, count), do: take(list, count, [])
  def take([], _count, result), do: reverse(result)
  def take(_list, 0, result), do: reverse(result)
  def take([head|tail], count, result), do: take(tail, count - 1, [head|result])

  def flatten(list), do: flatten(list, [])
  def flatten([], result), do: reverse(result)
  def flatten([head|tail], result) when is_list(head) do
    flatten(head ++ tail, result)
  end
  def flatten([head|tail], result), do: flatten(tail, [head|result])
end
