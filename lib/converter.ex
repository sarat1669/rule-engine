defmodule RuleEngine.Converter do
  import RuleEngine.Retriever

  def convert(definition, facts) do
    do_convert(definition, facts)
  end

  defp do_convert(%{"type" => "null"}, _facts) do
    nil
  end

  defp do_convert(%{"type" => "true"}, _facts) do
    true
  end

  defp do_convert(%{"type" => "false"}, _facts) do
    false
  end

  defp do_convert(%{"type" => "integer", "arguments" => [ integer ]}, _facts) do
    Integer.parse(integer) |> elem(0)
  end

  defp do_convert(%{"type" => "float", "arguments" => [ float ]}, _facts) do
    Float.parse(float) |> elem(0)
  end

  defp do_convert(%{"type" => "string", "arguments" => [ word ]}, _facts) do
    word
  end

  defp do_convert(%{ "type" => "!", "arguments" => [ var ] }, facts) do
    { :!, [ do_convert(var, facts) ] }
  end

  defp do_convert(%{ "type" => "+", "arguments" => [ var ] }, facts) do
    { :+, [ do_convert(var, facts) ] }
  end

  defp do_convert(%{ "type" => "-", "arguments" => [ var ] }, facts) do
    { :-, [ do_convert(var, facts) ] }
  end

  defp do_convert(%{ "type" => "abs", "arguments" => [ var ] }, facts) do
    { :abs, [ do_convert(var, facts) ] }
  end

  defp do_convert(%{ "type" => "!=", "arguments" => [ left, right ] }, facts) do
    { :!=, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "!==", "arguments" => [ left, right ] }, facts) do
    { :!==, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "&&", "arguments" => [ left, right ] }, facts) do
    { :&&, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "||", "arguments" => [ left, right ] }, facts) do
    { :||, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "*", "arguments" => [ left, right ] }, facts) do
    { :*, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "++", "arguments" => [ left, right ] }, facts) do
    { :++, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "+", "arguments" => [ left, right ] }, facts) do
    { :+, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "--", "arguments" => [ left, right ] }, facts) do
    { :--, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "-", "arguments" => [ left, right ] }, facts) do
    { :-, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "/", "arguments" => [ left, right ] }, facts) do
    { :/, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "<", "arguments" => [ left, right ] }, facts) do
    { :<, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "<=", "arguments" => [ left, right ] }, facts) do
    { :<=, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "<>", "arguments" => [ left, right ] }, facts) do
    { :<>, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "==", "arguments" => [ left, right ] }, facts) do
    { :==, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "===", "arguments" => [ left, right ] }, facts) do
    { :===, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => ">", "arguments" => [ left, right ] }, facts) do
    { :>, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => ">=", "arguments" => [ left, right ] }, facts) do
    { :>=, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "rem", "arguments" => [ left, right ] }, facts) do
    { :rem, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{ "type" => "includes", "arguments" => [ left, right ] }, facts) do
    { :includes, [ do_convert(left, facts), do_convert(right, facts) ] }
  end

  defp do_convert(%{"type" => "fact", "arguments" => path}, facts) do
    retrieve(facts, path |> Enum.map(&do_convert(&1, facts)) )
  end

  defp do_convert(%{ "type" => "list", "arguments" => elements }, facts) do
    { :list, Enum.map(elements, &do_convert(&1, facts)) }
  end

  defp do_convert(%{ "type" => "sum", "arguments" => arguments }, facts) do
    { :sum, Enum.map(arguments, &do_convert(&1, facts)) }
  end
end
