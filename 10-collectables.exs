Enum.into 1..5, []
# [1, 2, 3, 4, 5]
Enum.into 1..5, [100, 101]
# [100, 101, 1, 2, 3, 4, 5]
Enum.into IO.stream(:stdio, :line), IO.stream(:stdio, :line)
# hello
# hello
# hi mom
# hi mom
# bye
# bye

for x <- [ 1, 2, 3, 4, 5 ], do: x*x
# [1, 4, 9, 16, 25]
for x <- [ 1, 2, 3, 4, 5 ], x < 4, do: x*x
# [1, 4, 9]
for x <- [1,2], y <- [5,6], do: {x, y}
# [{1, 5}, {1, 6}, {2, 5}, {2, 6}]
for x <- [1,2], y <- [5,6], do: x * y
# [5, 6, 10, 12]
min_maxes = [{1,4}, {2,3}, {10,15}]
# [{1, 4}, {2, 3}, {10, 15}]
for {min, max} <- min_maxes, n <- min..max, do: n
# [1, 2, 3, 4, 2, 3, 10, 11, 12, 13, 14, 15]
collection = Enum.to_list(1..8)
# [1, 2, 3, 4, 5, 6, 7, 8]
for x <- collection, y <- collection, x >= y, rem(x*y, 10) == 0, do: {x, y}
# [{5, 2}, {5, 4}, {6, 5}, {8, 5}]
reports = [ dallas: :hot, minneapolis: :cold, dc: :muggy, la: :smoggy ]
# [dallas: :hot, minneapolis: :cold, dc: :muggy, la: :smoggy]
for { city, weather } <- reports, do: { weather, city }
# [hot: :dallas, cold: :minneapolis, muggy: :dc, smoggy: :la]
for << ch <- "hello" >>, do: ch
# 'hello'
for << ch <- "hello" >>, do: <<ch>>
# ["h", "e", "l", "l", "o"]

name = "Dave"
# "Dave"
for name <- ["hello", "mom"], do: String.upcase(name)
# ["HELLO", "MOM"]
name
# "Dave"

for x <- ~w{ cat dog }, into: %{}, do: { x, String.upcase(x) }
# %{"cat" => "CAT", "dog" => "DOG"}
for x <- ~w{ cat dog }, into: Map.new, do: { x, String.upcase(x) }
# %{"cat" => "CAT", "dog" => "DOG"}
for x <- ~w{ cat dog }, into: %{"ant" => "ANT"}, do: { x, String.upcase(x) }
# %{"ant" => "ANT", "cat" => "CAT", "dog" => "DOG"}
for x <- ~w{ cat dog }, into: IO.stream(:stdio, :line), do: "<<#{x}>>\n"
# <<cat>>
# <<dog>>
# %IO.Stream{device: :standard_io, line_or_bytes: :line, raw: false}
