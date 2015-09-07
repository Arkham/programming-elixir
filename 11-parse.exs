defmodule Parse do
  def number([ ?- | tail ]), do: _number_digits(tail, 0) * -1
  def number([ ?+ | tail ]), do: _number_digits(tail, 0)
  def number(str),           do: _number_digits(str, 0)

  defp _number_digits([], result), do: result
  defp _number_digits([head | tail], result)
  when head in '0123456789' do
    _number_digits(tail, result * 10 + head - ?0)
  end
  defp _number_digits([char | _], _), do: raise "Invalid character '#{[char]}'"

  def printable_ascii?([]), do: true
  def printable_ascii?([head | tail])
  when head in ?\s..?~ do
    printable_ascii?(tail)
  end
  def printable_ascii?(_), do: false

  def anagram?(first, second) when length(first) != length(second), do: false
  def anagram?(first, second), do: length(first -- second) == 0

  def calculate(expression), do: _calculate(expression, 0)

  defp _calculate([head|tail], first)
  when head in '0123456789' do
    _calculate(tail, first * 10 + head - ?0)
  end
  defp _calculate([head|tail], first)
  when head == ?\s do
    _calculate(tail, first)
  end
  defp _calculate([head|tail], first) do
    _calculate(tail, first, head, 0)
  end

  defp _calculate([], first, operator, second) do
    case operator do
      ?+ -> first + second
      ?- -> first - second
      ?* -> first * second
      ?/ -> first / second
    end
  end
  defp _calculate([head|tail], first, operator, second)
  when head == ?\s do
    _calculate(tail, first, operator, second)
  end
  defp _calculate([head|tail], first, operator, second) do
    _calculate(tail, first, operator, second * 10 + head - ?0)
  end
end
