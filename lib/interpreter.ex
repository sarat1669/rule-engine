defmodule RuleEngine.Interpreter do
  def interpret(dsl) do
    do_interpret(dsl)
  end

  defp do_interpret({ :!, [ var ] }) do
    quote do
      !unquote(do_interpret(var))
    end
  end

  defp do_interpret({ :+, [ var ] }) do
    quote do
      +unquote(do_interpret(var))
    end
  end

  defp do_interpret({ :-, [ var ] }) do
    quote do
      -unquote(do_interpret(var))
    end
  end

  defp do_interpret({ :abs, [ var ]}) do
    quote do
      abs(unquote(do_interpret(var)))
    end
  end

  defp do_interpret({ :=, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) = unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :!=, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) != unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :!==, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) !== unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :&&, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) && unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :||, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) || unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :*, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) * unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :++, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) ++ unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :+, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) + unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :--, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) -- unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :-, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) - unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :/, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) / unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :<, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) < unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :<=, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) <= unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :<>, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) <> unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :==, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) == unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :===, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) === unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :>, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) > unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :>=, [ left, right ] }) do
    quote do
      unquote(do_interpret(left)) >= unquote(do_interpret(right))
    end
  end

  defp do_interpret({ :rem, [ left, right ] }) do
    quote do
      rem(unquote(do_interpret(left)), unquote(do_interpret(right)))
    end
  end

  defp do_interpret({ :includes, [ left, right ] }) do
    list = quote do: unquote(do_interpret(left))
    value = quote do: unquote(do_interpret(right))
    Enum.member?(list, value)
  end

  defp do_interpret({ :list, elements }) do
    Enum.map(elements, fn(element) ->
      quote do: unquote do_interpret(element)
    end)
  end

  defp do_interpret({ :sum, arguments }) do
    [ h | t ] = arguments
    value = quote do: unquote do_interpret(h)
    Enum.reduce(t, value, fn(n, acc) ->
      a = quote do: unquote do_interpret(n)
      { :+, [], [a, acc]}
    end)
  end

  defp do_interpret(nil), do: nil

  defp do_interpret(true), do: true

  defp do_interpret(false), do: false

  defp do_interpret(x) when is_map(x), do: x

  defp do_interpret(x) when is_list(x), do: x

  defp do_interpret(x) when is_binary(x), do: x

  defp do_interpret(x) when is_number(x), do: x
end
