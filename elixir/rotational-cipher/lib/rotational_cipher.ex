defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(&(rot(&1, shift)))
    |> to_string()
  end

  defp rot(char, shift) when char in ?A..?Z do
    shift_character(char, shift, ?A, ?Z)
  end

  defp rot(char, shift) when char in ?a..?z do
    shift_character(char, shift, ?a, ?z)
  end

  defp rot(char, _shift), do: char

  defp shift_character(char, shift, lower_limit, upper_limit) do
    cond do
      char + shift <= upper_limit -> char + shift

      char + shift > upper_limit -> lower_limit + char + shift - upper_limit - 1
    end
  end
end
