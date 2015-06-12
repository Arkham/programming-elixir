fun1 = fn ->
  fn ->
    "Hello"
  end
end

other = fun1.()
IO.puts other.()

greeter = fn name ->
  fn ->
    "Hello #{name}"
  end
end

dave_greeter = greeter.("Dave")
IO.puts dave_greeter.()

add_n = fn n ->
  fn other ->
    n + other
  end
end

add_two = add_n.(2)
add_five = add_n.(5)

IO.puts add_two.(10)
IO.puts add_five.(12)
