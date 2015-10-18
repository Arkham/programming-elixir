defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: List do
  def encrypt(string, shift) do
    string
    |> Enum.map(fn char ->
      ?a + rem (char - ?a + shift), (?z - ?a + 1)
    end)
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end

defimpl Caesar, for: BitString do
  def encrypt(string, shift) do
    string
    |> String.to_char_list
    |> Caesar.encrypt(shift)
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end

defmodule Test do
  IO.inspect Caesar.encrypt('abcz', 1)
  IO.inspect Caesar.encrypt("abcz", 1)
end
