defmodule LineCommeSigil do
  def sigil_v(lines, _options) do
    lines
    |> String.strip
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.split(line, ",")
      |> Enum.map(&parse_float/1)
    end)
  end

  def parse_float(string) do
    case Float.parse(string) do
      :error ->
        string
      {num, _} ->
        num
    end
  end
end

defmodule Test do
  import LineCommeSigil

  def test do
    ~v"""
    1,2,3.14
    cat,dog
    """
  end
end

IO.inspect Test.test
