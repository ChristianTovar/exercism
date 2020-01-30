defmodule ProteinTranslation do
  @cystenine ["UGU", "UGC"]
  @leucine ["UUA", "UUG"]
  @methionine ["AUG"]
  @pheylalanine ["UUU", "UUC"]
  @serine ["UCU", "UCC", "UCA", "UCG"]
  @tryptophan ["UGG"]
  @tyrosine ["UAU", "UAC"]
  @stop ["UAA", "UAG", "UGA"]

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    list =
      String.codepoints(rna)
      |> Enum.chunk_every(3)
      |> Enum.map(fn [a, b, c] -> of_codon(a <> b <> c) end)
      |> Enum.reduce_while([], fn {_atom, codon}, acc ->
        if codon != "STOP",
          do: {:cont, acc ++ [codon]},
          else: {:halt, acc}
      end)

    case has_invalid_codons?(list) do
      true -> {:error, "invalid RNA"}
      false -> {:ok, list}
    end
  end

  defp has_invalid_codons?(list) do
    Enum.member?(list, "invalid codon")
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) when codon in @cystenine, do: {:ok, "Cysteine"}
  def of_codon(codon) when codon in @leucine, do: {:ok, "Leucine"}
  def of_codon(codon) when codon in @methionine, do: {:ok, "Methionine"}
  def of_codon(codon) when codon in @pheylalanine, do: {:ok, "Phenylalanine"}
  def of_codon(codon) when codon in @serine, do: {:ok, "Serine"}
  def of_codon(codon) when codon in @tryptophan, do: {:ok, "Tryptophan"}
  def of_codon(codon) when codon in @tyrosine, do: {:ok, "Tyrosine"}
  def of_codon(codon) when codon in @stop, do: {:ok, "STOP"}
  def of_codon(_codon), do: {:error, "invalid codon"}
end
