list = Enum.to_list 1..5
# [1, 2, 3, 4, 5]
Enum.concat([1,2,3], [4,5,6])
# [1, 2, 3, 4, 5, 6]
Enum.concat([1,2,3], 'abc')
# [1, 2, 3, 97, 98, 99]
Enum.map(list, &(&1 * 10))
# [10, 20, 30, 40, 50]
Enum.map(list, &String.duplicate("*", &1))
# ["*", "**", "***", "****", "*****"]
Enum.at(10..20, 3)
# 13
Enum.at(10..20, 20)
# nil
Enum.at(10..20, 20, :no_one_here)
# :no_one_here
Enum.filter(list, &(&1 > 2))
# [3, 4, 5]
Enum.filter(list, &Integer.is_even/1)
# [2, 4]
Enum.reject(list, &Integer.is_even/1)
# [1, 3, 5]
Enum.sort ["there", "was", "a", "crooked", "man"]
# ["a", "crooked", "man", "there", "was"]
Enum.sort ["there", "was", "a", "crooked", "man"], &(String.length(&1) <= String.length(&2))
# ["a", "was", "man", "there", "crooked"]
Enum.max ["there", "was", "a", "crooked", "man"]
# "was"
Enum.max_by ["there", "was", "a", "crooked", "man"], &String.length/1
# "crooked"
Enum.take(list, 3)
# [1, 2, 3]
Enum.take_every list, 2
# [1, 3, 5]
Enum.take_while(list, &(&1 < 4))
# [1, 2, 3]
Enum.split(list, 3)
# {[1, 2, 3], [4, 5]}
Enum.split_while(list, &(&1 < 4))
# {[1, 2, 3], [4, 5]}
Enum.join(list)
# "12345"
Enum.join(list, ", ")
# "1, 2, 3, 4, 5"
Enum.all?(list, &(&1 < 4))
# false
Enum.any?(list, &(&1 < 4))
# true
Enum.member?(list, 4)
# true
Enum.empty?(list)
# false
Enum.zip(list, [:a, :b, :c])
# [{1, :a}, {2, :b}, {3, :c}]
Enum.with_index(["once", "upon", "a", "time"])
# [{"once", 0}, {"upon", 1}, {"a", 2}, {"time", 3}]

Enum.reduce(1..100, &(&1 + &2))
# 5050
Enum.reduce(["now", "is", "the", "time"], fn word, longest ->
  if String.length(word) > String.length(longest) do
    word
  else
    longest
  end
end)
# "time"
Enum.reduce(["now", "is", "the", "time"], 0, fn word, longest ->
  if String.length(word) > longest do
    String.length(word)
  else
    longest
  end
end)
# 4
