defmodule RuleEngine.Retriever do
  def retrieve(facts, path) do
    get_fact_and_retrieve(facts, path)
  end

  defp get_fact_and_retrieve(facts, [fact | path]) do
    do_retrieve(path, Map.get(facts, fact))
  end

  defp do_retrieve([ current | path ], data) do
    data = do_retrieve(current, data)
    do_retrieve(path, data)
  end

  defp do_retrieve([], data) do
    data
  end

  defp do_retrieve(key, map) when (is_number(key) or is_binary(key)) and is_map(map) do
    Map.get(map, key)
  end

  defp do_retrieve(index, list) when is_number(index) and is_list(list) do
    Enum.at(list, index)
  end

  defp do_retrieve(_, _) do
    nil
  end
end
