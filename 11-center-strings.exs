defmodule CenterStrings do
  def call(collection) do
    max_length = Enum.map(collection, &String.length/1) |> Enum.max

    Enum.each(collection, fn el ->
      IO.puts _justify(el, max_length)
    end)
  end

  defp _justify(str, length) do
    str_length = String.length(str)
    offset = round((length - str_length)/2)
    String.rjust(String.ljust(str, str_length + offset), length)
  end
end
