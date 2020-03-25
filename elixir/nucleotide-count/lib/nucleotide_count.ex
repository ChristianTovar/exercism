defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide), do: Enum.count(strand, &(nucleotide == &1))

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    empty_histogram = get_empty_histogram()
    current_histogram = Enum.frequencies(strand)
    Map.merge(empty_histogram, current_histogram)
  end

  defp get_empty_histogram, do: Enum.reduce(@nucleotides, %{}, &Map.put_new(&2, &1, 0))
end
