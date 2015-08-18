defmodule Example do
  @author "Ju Liu"

  def get_author do
    @author
  end

  @attr "one"
  def first, do: @attr

  @attr "two"
  def second, do: @attr
end

IO.puts Example.get_author
IO.puts "#{Example.first} #{Example.second}"
