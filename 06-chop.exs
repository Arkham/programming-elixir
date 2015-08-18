defmodule Chop do
  def guess(secret, first..last) when secret == first do
    IO.puts secret
  end

  def guess(secret, first..last) do
    pivot = first + div(last - first, 2)
    IO.puts "Is it #{pivot}"
    guess(secret, first..last, pivot)
  end

  def guess(secret, first..last, pivot) when pivot > secret do
    guess(secret, first..pivot)
  end

  def guess(secret, first..last, pivot) when pivot <= secret do
    guess(secret, pivot..last)
  end
end
