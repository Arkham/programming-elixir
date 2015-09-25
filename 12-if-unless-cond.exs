if 1 == 1, do: "true", else: "false"
# "true"
if 1 == 2, do: "true", else: "false"
# "false"
unless 1 == 2, do: "true", else: "false"
# "true"

defmodule FizzBuzz do
  def upto(n) when n > 0, do: _upto(1, n, [])

  defp _upto(current, limit, result) when current === limit, do: Enum.reverse(result)

  defp _upto(current, limit, result) do
    next =
      cond do
        rem(current, 3) === 0 and rem(current, 5) === 0 ->
          "Fizzbuzz"
        rem(current, 3) === 0 ->
          "Fizz"
        rem(current, 5) === 0 ->
          "Buzz"
        true ->
          current
      end

    _upto(current + 1, limit, [ next | result ])
  end
end

defmodule FizzBuzz2 do
  def upto(n) when n > 0, do: _downto(n, [])

  defp _downto(0, result), do: result

  defp _downto(current, result) do
    next =
      cond do
        rem(current, 3) === 0 and rem(current, 5) === 0 ->
          "FizzBuzz"
        rem(current, 3) === 0 ->
          "Fizz"
        rem(current, 5) === 0 ->
          "Buzz"
        true ->
          current
      end

    _downto(current - 1, [ next | result ])
  end
end

defmodule FizzBuzz3 do
  def upto(n) when n > 0 do
    1..n |> Enum.map(&fizzbuzz/1)
  end

  defp fizzbuzz(n) do
    cond do
      rem(n, 3) === 0 and rem(n, 5) === 0 ->
        "FizzBuzz"
      rem(n, 3) === 0 ->
        "Fizz"
      rem(n, 5) === 0 ->
        "Buzz"
      true ->
        n
    end
  end
end

defmodule FizzBuzz4 do
  def upto(n) when n > 0 do
    1..n |> Enum.map(&fizzbuzz/1)
  end

  defp fizzbuzz(n) when rem(n, 3) === 0 and rem(n, 5) === 0, do: "FizzBuzz"
  defp fizzbuzz(n) when rem(n, 3) === 0, do: "Fizz"
  defp fizzbuzz(n) when rem(n, 5) === 0, do: "Buzz"
  defp fizzbuzz(n), do: n
end

defmodule FizzBuzz5 do
  def upto(n) when n > 0 do
    1..n |> Enum.map(&fizzbuzz/1)
  end

  defp fizzbuzz(n) do
    case { rem(n, 3), rem(n, 5) } do
      { 0, 0 } ->
        "FizzBuzz"
      { 0, _ } ->
        "Fizz"
      { _, 0 } ->
        "Buzz"
      _ ->
        n
    end
  end
end
