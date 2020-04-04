defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input),
    do: Enum.reduce(input, %{}, fn {value, list}, acc -> count_words(list, value, acc) end)

  defp count_words(list, value, acc) do
    list
    |> Enum.map(&{String.downcase(&1), value})
    |> Enum.into(%{})
    |> Map.merge(acc)
  end
end
