defmodule IssuesTest do
  use ExUnit.Case

  import Issues.CLI, only: [ parse_args: 1 ]

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
end
