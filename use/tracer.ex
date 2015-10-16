defmodule Tracer do
  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
      import IO.ANSI, only: [yellow: 0, green: 0, cyan: 0, reset: 0]
    end
  end

  defmacro def(definition = {:when, _, [{name, _, args}, _rest]}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts "#{yellow}==> #{cyan}call   #{reset}#{Tracer.dump_defn(unquote(name), unquote(args))}"
        result = unquote(content)
        IO.puts "#{yellow}<== #{green}result #{reset}#{result}"
        result
      end
    end
  end

  defmacro def(definition = {name, _, args}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts "#{yellow}==> #{cyan}call   #{reset}#{Tracer.dump_defn(unquote(name), unquote(args))}"
        result = unquote(content)
        IO.puts "#{yellow}<== #{green}result #{reset}#{result}"
        result
      end
    end
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  def dump_args(args) do
    args
    |> Enum.map(&inspect/1)
    |> Enum.join(", ")
  end
end

defmodule Test do
  use Tracer

  def puts_sum_three(a, b, c), do: IO.inspect(a + b + c)
  def add_list(list),          do: Enum.reduce(list, 0, &(&1 + &2))
  def puts_num(n) when n > 0 and n < 10,  do: IO.inspect(n)
end

Test.puts_sum_three(1, 2, 3)
Test.add_list([5, 6, 7, 8])
Test.puts_num(8)
Test.puts_num(-1)
