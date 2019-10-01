defmodule RuleEngineTest do
  use ExUnit.Case
  doctest RuleEngine

  test "evaluate the rule" do
    rule = %{
      "type" => "&&", "arguments" => [
        %{
          "type" => "==", "arguments" => [
              %{
                "type" => "fact", "arguments" => [
                  %{ "type" => "string", "arguments" => ["user"] },
                  %{ "type" => "string", "arguments" => ["name"] }
                ]
              },
              %{ "type" => "string", "arguments" => ["sample"] }
          ]
        },
        %{
          "type" => "!=", "arguments" => [
            %{
              "type" => "fact", "arguments" => [
                %{ "type" => "string", "arguments" => ["user"] },
                %{ "type" => "string", "arguments" => ["details"] },
                %{ "type" => "string", "arguments" => ["gender"] }
              ]
            },
            %{ "type" => "string", "arguments" => ["female"] }
          ]
        }
      ]
    }

    assert RuleEngine.evaluate(%{ "user" => %{ "name" => "sample", "details" => %{ "gender" => "male" } } }, rule) == true
  end
end
