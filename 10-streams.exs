s = Stream.map [1, 3, 5, 7], &(&1 + 1)
#Stream<[enum: [1, 3, 5, 7], funs: [#Function<45.113986093/1 in Stream.map/2>]]>
Enum.to_list s
# [2, 4, 6, 8]
squares = Stream.map [1, 2, 3, 4], &(&1*&1)
#Stream<[enum: [1, 2, 3, 4], funs: [#Function<45.113986093/1 in Stream.map/2>]]>
plus_ones = Stream.map squares, &(&1+1)
#Stream<[enum: [1, 2, 3, 4], funs: [#Function<45.113986093/1 in Stream.map/2>, #Function<45.113986093/1 in Stream.map/2>]]>
odds = Stream.filter plus_ones, fn x -> rem(x, 2) == 1 end
#Stream<[enum: [1, 2, 3, 4], funs: [#Function<45.113986093/1 in Stream.map/2>, #Function<45.113986093/1 in Stream.map/2>, #Function<39.113986093/1 in Stream.filter/2>]]>
Enum.to_list odds
# [5, 17]
IO.puts File.open!("/usr/share/dict/words") |> IO.stream(:line) |> Enum.max_by(&String.length/1)
# formaldehydesulphoxylate
Enum.map(1..10_000_000, &(&1+1)) |> Enum.take(5)
# [2, 3, 4, 5, 6]
Stream.map(1..10_000_000, &(&1+1)) |> Enum.take(5)
# [2, 3, 4, 5, 6]

Stream.cycle(~w{ green white }) |>
  Stream.zip(1..5) |>
  Enum.map(fn {class, value} ->
    ~s{<tr class="#{class}"></td>#{value}</td></tr>\n} end) |>
  IO.puts
# <tr class="green"></td>1</td></tr>
# <tr class="white"></td>2</td></tr>
# <tr class="green"></td>3</td></tr>
# <tr class="white"></td>4</td></tr>
# <tr class="green"></td>5</td></tr>
Stream.cycle(~w{ green white }) |> Stream.zip(1..5) |> Enum.to_list
# [{"green", 1}, {"white", 2}, {"green", 3}, {"white", 4}, {"green", 5}]
Stream.repeatedly(fn -> true end) |> Enum.take(3)
# [true, true, true]
Stream.repeatedly(&:random.uniform/0) |> Enum.take(3)
# [0.7884226842442568, 0.07513646694898712, 0.8044536732853236]
Stream.iterate(0, &(&1+1)) |> Enum.take(5)
# [0, 1, 2, 3, 4]
Stream.iterate(2, &(&1*&1)) |> Enum.take(5)
# [2, 4, 16, 256, 65536]
Stream.iterate([], &[&1]) |> Enum.take(5)
# [[], [[]], [[[]]], [[[[]]]], [[[[[]]]]]]
Stream.unfold({0, 1}, fn {f1, f2} -> {f1, {f2, f1+f2}} end) |> Enum.take(15)
# [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377]

Stream.resource(fn -> File.open!("README.md") end,
                fn file ->
                  case IO.read(file, :line) do
                    line when is_binary(line) -> { [line], file }
                    _ -> {:halt, file}
                  end
                end,
                fn file -> File.close(file) end) |> Enum.take(3)
# ["# Programming Elixir\n", "\n", "Code snippets for \"Programming Elixir\"\n"]
