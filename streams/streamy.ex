defmodule Streamy do
  def from(start) do
    Stream.resource(
      fn -> start end,
      fn(num) ->
        case num do
          num when num < 1000 ->
            {[num + 1], num + 1}
          _ ->
            {:halt, num}
        end
      end,
      fn(num) -> num end
    )
  end
end
