defmodule Sum do
  def values(dict) do
    dict |> Dict.values |> Enum.sum
  end
end

hd = [ one: 1, two: 2, three: 3 ] |> Enum.into HashDict.new
IO.puts Sum.values(hd)

map = %{ four: 4, five: 5, six: 6 }
IO.puts Sum.values(map)

kw_list = [ name: "Dave", likes: "Programming", where: "Dallas" ]
hashdict = Enum.into kw_list, HashDict.new
map = Enum.into kw_list, Map.new
IO.puts kw_list[:name]
IO.puts map[:where]

hashdict = Dict.drop(hashdict, [:where, :likes])
IO.inspect hashdict
hashdict = Dict.put(hashdict, :also_likes, "Ruby")
IO.inspect hashdict
combo = Dict.merge(map, hashdict)
IO.inspect combo

kw_list = [ name: "Dave", likes: "Programming", likes: "Elixir" ]
IO.inspect kw_list[:likes]
IO.inspect Dict.get(kw_list, :likes)
IO.inspect Keyword.get_values(kw_list, :likes)

person = %{ name: "Dave", height: 1.88 }
IO.inspect person

%{ name: a_name } = person
IO.inspect a_name
%{ name: _, height: _ } = person
%{ name: "Dave" }
%{ name: _, weight: _ } = person
