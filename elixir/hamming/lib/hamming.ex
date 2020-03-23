defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand1), do: {:ok, 0}

  def hamming_distance(strand1, strand2) when length(strand1) == length(strand2) do
    amount =
      strand1
      |> List.myers_difference(strand2)
      |> get_difference()

    {:ok, amount}
  end

  def hamming_distance(_, _), do: {:error, "Lists must be the same length"}

  defp get_difference(keyword) do
    keyword
    |> Enum.filter(fn {key, _value} -> key == :del end)
    |> Enum.map(fn {_key, value} -> value end)
    |> Enum.join()
    |> String.length()
  end
end
