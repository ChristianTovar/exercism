defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    sentence
    |> String.replace(~r/[^a-zA-Z]/, "")
    |> String.graphemes()
    |> Enum.frequencies()
    |> IO.inspect()
    |> all_letters?()
  end

  defp all_letters?(map) when map_size(map) > 25, do: true
  defp all_letters?(_map), do: false
end
