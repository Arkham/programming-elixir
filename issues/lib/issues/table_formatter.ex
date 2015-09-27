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
    column_widths = map(data_by_columns, &get_width/1)

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

  def extract_data(rows, headers) do
    for row <- rows do
      headers
        |> map(&(to_string(row[&1])))
    end
  end

  def transpose([[]|_]), do: []
  def transpose(list) do
    [map(list, &hd/1) | transpose(map(list, &tl/1))]
  end

  def get_width(list) do
    list
      |> map(&(String.length(&1)))
      |> max
  end
end
