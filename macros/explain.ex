defmodule Generate do
  defmacro op(atom, verb, joiner, suffix \\ "") do
    quote do
      def verb_for_op(unquote(atom)), do: unquote(verb)
      def joiner_for_op(unquote(atom)), do: unquote(joiner)
      def suffix_for_op(unquote(atom)), do: unquote(suffix)
    end
  end
end

defmodule Explain do
  require Generate

  Generate.op :+, "add", "and"
  Generate.op :-, "subtract", "from"
  Generate.op :*, "multiply", "by", " by"
  Generate.op :/, "divide", "by", " by"

  defmacro explain(clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    expr = Macro.escape(do_clause)

    quote do
      unquote(expr)
      |> humanize
      |> IO.puts
    end
  end

  def humanize(number) when is_number(number) do
    to_string(number)
  end

  def humanize({op, _, [lhs = {_, _, _}, rhs = {_, _, _}]}) do
    "#{humanize rhs}, then #{humanize lhs}, then #{verb_for_op op}"
  end

  def humanize({op, _, [lhs, rhs = {_, _, _}]}) do
    "#{humanize rhs}, then #{verb_for_op op}#{suffix_for_op op} #{humanize lhs}"
  end

  def humanize({op, meta, [lhs = {_, _, _}, rhs]}) do
    humanize({op, meta, [rhs, lhs]})
  end

  def humanize({op, _, [lhs, rhs]}) do
    "#{verb_for_op op} #{humanize lhs} #{joiner_for_op op} #{humanize rhs}"
  end
end

defmodule Test do
  import Explain

  explain do: 1 + 2
  explain do: 1 + 3 * 10
  explain do: 1 / 2 / 3 + 3
  explain do: 1 + 6 / 3 / 2
  explain do: 4 * 1 + 3 * 10
end
