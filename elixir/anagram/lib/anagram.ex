defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_map = string_to_map(base)

    candidates
    |> Enum.filter(&anagram?(base_map, &1))
    |> Enum.reject(&(&1 == base))
    |> Enum.reject(&repeated?(base, &1))
  end

  defp string_to_map(string) do
    string
    |> String.downcase()
    |> String.graphemes()
    |> Enum.frequencies()
  end

  defp anagram?(base_map, candidate) do
    candidate_map = string_to_map(candidate)
    base_map == candidate_map
  end

  defp repeated?(base, candidate) do
    String.downcase(base) == String.downcase(candidate)
  end
end
