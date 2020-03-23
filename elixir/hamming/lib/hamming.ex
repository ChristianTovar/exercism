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
    get_difference(strand1, strand2, 0)
  end

  def hamming_distance(_, _), do: {:error, "Lists must be the same length"}

  defp get_difference([], [], acc), do: {:ok, acc}

  defp get_difference([head_1 | tail_1], [head_2 | tail_2], acc) when head_1 != head_2,
    do: get_difference(tail_1, tail_2, acc + 1)

  defp get_difference([_head_1 | tail_1], [_head_2 | tail_2], acc),
    do: get_difference(tail_1, tail_2, acc)
end
