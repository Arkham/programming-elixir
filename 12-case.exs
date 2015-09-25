case File.open("README.md") do
  { :ok, file } ->
    IO.puts "First line: #{IO.read(file, :line)}"
  { :error, reason } ->
    IO.puts "Failed to open file: #{reason}"
end

defmodule Users do
  dave = %{ name: "Dave", state: "TX", likes: "programming", age: 30 }

  case dave do
    %{ state: some_state } = person ->
      IO.puts "#{person.name} lives in #{some_state}"

    _ ->
      IO.puts "No matches"
  end

  case dave do
    person = %{ age: age } when is_number(age) and age >= 21 ->
      IO.puts "You are cleared to enter the bar, #{person.name}"

    _ ->
      IO.puts "Sorry, no admission"
  end
end
