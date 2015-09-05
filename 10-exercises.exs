defmodule Ex do
  def span(from, to) do
    for n <- from..to, do: n
  end

  def prime_until(n) do
    for x <- span(2, n), is_prime(x), do: x
  end

  def is_prime(n) do
    factors = for x <- span(2, n), rem(n, x) == 0, do: x
    length(factors) == 1
  end
end

IO.inspect(Ex.span(1,10))
IO.inspect(Ex.prime_until(100))

tax_rates = [ NC: 0.075, TX: 0.08 ]
orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount: 35.50 ],
  [ id: 125, ship_to: :TX, net_amount: 24.00 ],
  [ id: 126, ship_to: :TX, net_amount: 44.80 ],
  [ id: 127, ship_to: :NC, net_amount: 25.00 ],
  [ id: 128, ship_to: :MA, net_amount: 10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 130, ship_to: :NC, net_amount: 50.00 ] ]

calculate_total = fn (tax_rates, orders) ->
  Enum.map(orders, fn (order) ->
    tax_rate = Keyword.get(tax_rates, order[:ship_to], 0)
    total = order[:net_amount] * (1 + tax_rate)
    Keyword.put(order, :net_amount, total)
  end)
end

IO.inspect calculate_total.(tax_rates, orders)
