defmodule Exercise do
  def float_to_2_decimal_string(float) do
    :io.format("~.2f~n", [float])
  end

  def read_env(name) do
    System.get_env(name)
  end

  def get_extension(filename) do
    Path.extname(filename)
  end

  def get_pwd do
    System.cwd()
  end

  def parse_json(string) do
    # JSON.decode(string)
  end

  def run_cmd(cmd) do
    cmd
    |> String.to_char_list
    |> :os.cmd
  end
end

IO.puts Exercise.float_to_2_decimal_string(1.2345)
IO.puts Exercise.read_env("PATH")
IO.puts Exercise.get_extension("dave/test.exs")
IO.puts Exercise.get_pwd()
IO.puts Exercise.run_cmd("ls")
