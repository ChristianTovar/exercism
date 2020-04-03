defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal("0"), do: 0

  def to_decimal(number) do
    case valid_number?(number) do
      true -> calculate_decimal(number)
      false -> 0
    end
  end

  defp valid_number?(number), do: number =~ ~r/^[0-1]*$/

  defp calculate_decimal(number) do
    number
    |> String.graphemes()
    |> Enum.reverse()
    |> do_calculation(0, 0)
  end

  defp do_calculation([], acc, _position), do: acc

  defp do_calculation([h | t], acc, position),
    do: do_calculation(t, acc + String.to_integer(h) * :math.pow(2, position), position + 1)
end
