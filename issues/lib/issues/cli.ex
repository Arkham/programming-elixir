defmodule Issues.CLI do
  @default_count 4

  def run(argv) do
    argv
      |> parse_args
      |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
      aliases: [ h: :help ])

    case parse do
      { [ help: true ], _, _ } ->
        :help
      { _, [ user, project, count ], _ } ->
        { user, project, String.to_integer(count) }
      { _, [ user, project ], _ } ->
        { user, project, @default_count }
      _ ->
        :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
      |> decode_response
      |> convert_to_list_of_hashdicts
      |> sort_into_ascending_order
      |> Enum.take(count)
      |> format_into_table
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end

  def convert_to_list_of_hashdicts(list) do
    list
      |> Enum.map(&Enum.into(&1, HashDict.new))
  end

  def sort_into_ascending_order(list) do
    list
      |> Enum.sort(&(&1["created_at"] < &2["created_at"]))
  end

  def format_into_table(list) do
    data = [headers | extract_data(list)]

    max_lens = Enum.map(transpose(data), &get_max_string_length/1)

    [ fitted_header | rows ] = for row <- data do
      Enum.zip(row, max_lens)
        |> Enum.map(&pad_value/1)
        |> Enum.join("|")
    end

    separator = max_lens
      |> Enum.map(fn len -> String.duplicate("-", len + 2) end)
      |> Enum.join("+")

    [ fitted_header, separator | rows ]
      |> Enum.map(&(&1 <> "\n"))
      |> Enum.join
  end

  def pad_value({value, length}) do
    " #{String.ljust(value, length, ?\s)} "
  end

  def headers do
    ["number", "created_at", "title"]
  end

  def extract_data(list) do
    for element <- list do
      headers
        |> Enum.map(&(element[&1]))
        |> Enum.map(&to_string/1)
    end
  end

  def transpose([[]|_]), do: []
  def transpose(list) do
    [Enum.map(list, &hd/1) | transpose(Enum.map(list, &tl/1))]
  end

  def get_max_string_length(list) do
    list
      |> Enum.map(&(String.length(to_string(&1))))
      |> Enum.max
  end
end
