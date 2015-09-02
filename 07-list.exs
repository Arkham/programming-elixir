p = fn(value) ->
  IO.inspect(value)
end

p.([1,2,3] ++ [4,5,6])
p.(List.flatten([[[1], 2], [[[3]]]]))
p.(List.foldl([1,2,3], "", fn value, acc -> "#{value}(#{acc})" end))
p.(List.foldr([1,2,3], "", fn value, acc -> "#{value}(#{acc})" end))
p.(List.zip([[1,2,3], [:a, :b, :c], ["cat", "dog"]]))
p.(kw = [{:name, "Dave"}, {:likes, "Programming"}, {:where, "Dallas", "TX"}])
p.(List.keyfind(kw, "Dallas", 1))
p.(List.keyfind(kw, "TX", 2))
p.(List.keyfind(kw, "TX", 1))
p.(List.keyfind(kw, "TX", 1, "No city called TX"))
p.(kw = List.keydelete(kw, "TX", 2))
p.(kw = List.keyreplace(kw, :name, 0, {:first_name, "Dave"}))
