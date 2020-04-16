defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand1), do: {:ok, 0}

  def hamming_distance(strand1, strand2) do
    get_difference(strand1, strand2, 0)
  end

  defp get_difference([], [], acc), do: {:ok, acc}

  defp get_difference([_head_1 | _tail_1], [], _acc),
    do: {:error, "Lists must be the same length"}

  defp get_difference([], [_head_2 | _tail_2], _acc),
    do: {:error, "Lists must be the same length"}

  defp get_difference([head | tail_1], [head | tail_2], acc),
    do: get_difference(tail_1, tail_2, acc)

  defp get_difference([_head_1 | tail_1], [_head_2 | tail_2], acc),
    do: get_difference(tail_1, tail_2, acc + 1)
end
