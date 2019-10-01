defmodule RuleEngine do
  import RuleEngine.Converter
  import RuleEngine.Interpreter

  def evaluate(facts, validation_rule) do
    {response, _} = validation_rule
    |> convert(facts)
    |> interpret
    |> Code.eval_quoted

    if(response) do true else false end
  end
end
