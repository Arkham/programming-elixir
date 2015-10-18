defmodule LineSigil do
  @doc """
  Implement the `~l` sigil, which takes a string containing
  multiple lines and returns a list of those lines.
  """

  def sigil_l(lines, _opts) do
    lines |> String.rstrip |> String.split("\n")
  end
end

defmodule Test do
  import LineSigil

  def lines do
    ~l"""
    line 1
    line 2
    and some other stuff
    """
  end
end

IO.inspect Test.lines
