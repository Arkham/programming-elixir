defmodule My do
  defmacro mydef(name) do
    quote bind_quoted: [name: name] do
      def unquote(name)() do
        unquote(name)
      end
    end
  end
end

defmodule Test do
  require My

  My.mydef(:hello)

  [:fred, :bert] |> Enum.each(&My.mydef(&1))
end

IO.puts Test.hello
IO.puts Test.fred
