defmodule IssuesTest do
  use ExUnit.Case

  import Issues.CLI, only: [
    parse_args: 1,
    sort_into_ascending_order: 1,
    convert_to_list_of_hashdicts: 1,
    format_into_table: 1
  ]

  test "returns :help when -h or --help options are passed" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["-help", "anything"]) == :help
  end

  test "returns three values if three are passed" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "returns two values and default count if two are passed" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

  test "sorts the issues by ascending creation date" do
    data = fake_list([2, 1, 3])

    assert Enum.map(sort_into_ascending_order(data), &(&1["created_at"])) == [ 1, 2, 3 ]
  end

  test "formats the data nicely into a table" do
    data = fake_list([1, 20, 300])

    assert format_into_table(data) == """
     #   | created_at | title           
    -----+------------+-----------------
     1   | 1          | hello there 1   
     20  | 20         | hello there 20  
     300 | 300        | hello there 300 
    """
  end

  defp fake_list(values) do
   data = for value <- values do
     [
       {"id", value},
       {"created_at", value},
       {"title", "hello there #{value}"}
     ]
   end

   convert_to_list_of_hashdicts(data)
  end
end
