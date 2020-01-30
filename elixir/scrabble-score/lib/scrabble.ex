defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """

  @zero_point [" ", "\t", "\n"]
  @one_point ~w(A  E  I  O  U  L  N  R  S  T)
  @two_point ~w(D G)
  @three_point ~w(B C M P)
  @four_point ~w(F H V W Y)
  @five_point ~w(K)
  @eigth_point ~w(J X)
  @ten_point ~w(Q Z)

  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.graphemes()
    |> check_points(0)
  end

  defp check_points([], score), do: score

  defp check_points([current_letter | tail], score) when current_letter in @zero_point,
    do: check_points(tail, score + 0)

  defp check_points([current_letter | tail], score) when current_letter in @one_point,
    do: check_points(tail, score + 1)

  defp check_points([current_letter | tail], score) when current_letter in @two_point,
    do: check_points(tail, score + 2)

  defp check_points([current_letter | tail], score) when current_letter in @three_point,
    do: check_points(tail, score + 3)

  defp check_points([current_letter | tail], score) when current_letter in @four_point,
    do: check_points(tail, score + 4)

  defp check_points([current_letter | tail], score) when current_letter in @five_point,
    do: check_points(tail, score + 5)

  defp check_points([current_letter | tail], score) when current_letter in @eigth_point,
    do: check_points(tail, score + 8)

  defp check_points([current_letter | tail], score) when current_letter in @ten_point,
    do: check_points(tail, score + 10)
end
