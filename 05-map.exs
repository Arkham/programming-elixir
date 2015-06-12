p = fn (data) ->
  IO.inspect(data)
end

list = [1, 3, 5, 7, 9]

p.(Enum.map list, fn elem -> elem * 2 end)
p.(Enum.map list, fn elem -> elem * elem end)
p.(Enum.map list, fn elem -> elem > 6 end)

plus_one = &(&1 + 1)
p.(plus_one)
p.(Enum.map list, plus_one)

speak = &(IO.puts(&1))
p.(speak)
speak.("Hello, from speak")

rnd = &(Float.round(&1, &2))
p.(rnd)

rnd = &(Float.round(&2, &1))
p.(rnd)

my_abs = &abs(&1)
p.(my_abs)

divrem = &{ div(&1, &2), rem(&1, &2) }
p.(divrem.(13, 5))

p.(Enum.map [1, 2, 3, 4], &(&1 + 2))
Enum.map [1, 2, 3, 4], &(p.(&1))
