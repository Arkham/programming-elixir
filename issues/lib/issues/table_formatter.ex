defmodule Issues.TableFormatter do
  import Enum, only: [
    each: 2,
    map: 2,
    map_join: 3,
    max: 1,
    zip: 2
  ]

  def print_tables_for_columns(rows, headers) do
    data = [ headers | extract_data(rows, headers) ]
    data_by_columns = transpose(data)
    column_widths = map(data_by_columns, &get_max_width/1)

    [ formatted_headers | rows ] = for row <- data do
      zip(row, column_widths)
        |> map_join(" | ", &format_value/1)
    end

    separator_line = column_widths
      |> map_join("-+-", &(String.duplicate("-", &1)))

    [ formatted_headers, separator_line | rows ]
      |> map_join("", &(&1 <> "\n"))
  end

  def format_value({value, length}) do
    String.ljust(value, length, ?\s)
  end

  @doc """
  Extract data from a list of objects using the keys contained in the headers.

  ## Examples
  iex> Issues.TableFormatter.extract_data([%{id: 1, value: "one"}, %{id: 2, value: "two"}], [:value])
  [["one"], ["two"]]
  """

  def extract_data(rows, headers) do
    for row <- rows do
      headers
        |> map(&(to_string(row[&1])))
    end
  end

  @doc """
  Transposes an array of arrays, so that rows are turned into columns.

  ## Examples
    iex> Issues.TableFormatter.transpose([[1, 2], [3, 4]])
    [[1, 3], [2, 4]]
    iex> Issues.TableFormatter.transpose([[1, 2, 3, 4]])
    [[1], [2], [3], [4]]
  """

  def transpose([[]|_]), do: []
  def transpose(list) do
    [map(list, &hd/1) | transpose(map(list, &tl/1))]
  end

  @doc """
  Returns the maximum length of the strings in the given list.

  ## Examples
    iex> Issues.TableFormatter.get_max_width(~w{mom dad hello helicopter})
    10
  """

  def get_max_width(list) do
    list
      |> map(&(String.length(&1)))
      |> max
  end
end
