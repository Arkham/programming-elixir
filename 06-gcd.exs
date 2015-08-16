defmodule GCD do
  def of(x, 0), do: x
  def of(x, y), do: of(y, rem(x, y))
end

# gcd 10, 15
# gcd 15, rem(10, 15)
# gcd 15, 10
# gcd 10, rem(15, 10)
# gcd 10, 5
# gcd 5, rem(10, 5)
# gcd 5, 0
