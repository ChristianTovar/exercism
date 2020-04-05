defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @consonant_replacement ~r/^[^aiueo]*/
  @consonant_with_qu_replacement ~r/^[^aiueo]*?qu/

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map_join(" ", &do_translation/1)
  end

  defp do_translation(word) do
    cond do
      vowel?(word) -> add_suffix(word)
      consonant_with_qu?(word) -> replace_and_swap(word, @consonant_with_qu_replacement)
      true -> replace_and_swap(word, @consonant_replacement)
    end
  end

  defp vowel?(word), do: String.starts_with?(word, ~W(a e i o u)) or word =~ ~r/^[xy][^aiueo]/

  defp consonant_with_qu?(word), do: word =~ ~r/^[^aiueo]*?qu/

  defp add_suffix(word), do: "#{word}ay"

  defp replace_and_swap(word, replacement) do
    replaced_consonant = String.replace(word, replacement, "")
    consonant = String.replace_suffix(word, replaced_consonant, "")
    add_suffix(replaced_consonant <> consonant)
  end
end
