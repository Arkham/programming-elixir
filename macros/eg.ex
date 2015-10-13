defmodule My do
  defmacro macro(code) do
    IO.inspect code

    quote do
      unquote(code)
      IO.puts "Different code"
    end
  end
end

defmodule Test do
  require My
  My.macro(IO.puts("hello"))
end
