defmodule Mod do
  def func1 do
    IO.puts "in func1"
  end

  def func2 do
    func1
    IO.puts "in func2"
  end
end

Mod.func1
Mod.func2

defmodule Outer do
  defmodule Inner do
    def inner_func do
      IO.puts "in inner_func"
    end
  end

  def outer_func do
    Inner.inner_func
    IO.puts "in outer_func"
  end
end

Outer.outer_func
Outer.Inner.inner_func
