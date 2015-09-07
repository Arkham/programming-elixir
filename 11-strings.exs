IO.puts "start"
IO.write "
  my
  string
"
IO.puts "end"

IO.puts "start"
IO.write """
  my
  string
  """
IO.puts "end"

IO.inspect ~C[1\n2#{1+2}]
IO.inspect ~c[1\n2#{1+2}]
IO.inspect ~S[1\n2#{1+2}]
IO.inspect ~s[1\n2#{1+2}]
IO.inspect ~W[the c#{'a'}t sat on the mat]
IO.inspect ~w[the c#{'a'}t sat on the mat]a
IO.inspect ~w[the c#{'a'}t sat on the mat]c
IO.inspect ~w[the c#{'a'}t sat on the mat]s

str = 'wombat'
# 'wombat'
is_list str
# true
length str
# 6
Enum.reverse str
# 'tabmow'
[ 67, 65, 84 ]
# 'CAT'
:io.format "~w~n", [ str ]
# [119,111,109,98,97,116]
# :ok
List.to_tuple str
# {119, 111, 109, 98, 97, 116}
str ++ [0]
# [119, 111, 109, 98, 97, 116, 0]
str
# 'wombat'
'∂x/∂y'
# [8706, 120, 47, 8706, 121]
'pole' ++ 'vault'
# 'polevault'
'pole' -- 'vault'
# 'poe'
List.zip [ 'abc', '123' ]
# [{97, 49}, {98, 50}, {99, 51}]
[ head | tail ] = 'cat'
# 'cat'
head
# 99
tail
# 'at'
[ head | tail ]
# 'cat'
?c
# 99
