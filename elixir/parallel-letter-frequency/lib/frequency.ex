defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> format_texts()
    |> Task.async_stream(&count_words/1, max_concurrency: workers)
    |> Enum.reduce(%{}, fn {:ok, map}, acc -> add_maps(map, acc) end)
  end

  defp format_texts(texts), do: Enum.map(texts, &String.replace(&1, ~r/[^a-zA-Z\x7f-\xff]/, ""))

  defp count_words(string) do
    string
    |> String.downcase()
    |> String.graphemes()
    |> Enum.frequencies()
  end

  defp add_maps(map, acc),
    do:
      Enum.reduce(map, acc, fn {key, value}, acc -> Map.update(acc, key, value, &(&1 + value)) end)
end
