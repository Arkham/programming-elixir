import Enum

defmodule Cards do
  def deck do
    for rank <- '23456789TJQKA', suit <- 'CDHS', do: [suit, rank]
  end

  def shuffle_deck do
    deck |> shuffle
  end

  def deal(size) do
    shuffle_deck |> take(size)
  end

  def groups(size) do
    shuffle_deck |> chunk(size)
  end
end
