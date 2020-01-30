defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, fn neu -> transcript(neu) end)
  end

  defp transcript(dna) when dna == ?G, do: ?C
  defp transcript(dna) when dna == ?C, do: ?G
  defp transcript(dna) when dna == ?T, do: ?A
  defp transcript(dna) when dna == ?A, do: ?U
end
