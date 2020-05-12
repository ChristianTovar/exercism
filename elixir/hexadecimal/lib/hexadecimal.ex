defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    case valid_hex?(hex) do
      true -> get_decimal(hex)
      false -> 0
    end
  end

  defp valid_hex?(hex), do: hex =~ ~r/^[0-9a-fA-F]+$/

  defp get_decimal(hex) do
    size = String.length(hex) - 1

    hex
    |> String.graphemes()
    |> Enum.zip(size..0)
    |> Enum.reduce(0, fn {letter, position}, acc -> acc + get_value(letter, position) end)
  end

  defp get_value(letter, position) when letter in ["a", "A"], do: 10 * :math.pow(16, position)
  defp get_value(letter, position) when letter in ["b", "B"], do: 11 * :math.pow(16, position)
  defp get_value(letter, position) when letter in ["c", "C"], do: 12 * :math.pow(16, position)
  defp get_value(letter, position) when letter in ["d", "D"], do: 13 * :math.pow(16, position)
  defp get_value(letter, position) when letter in ["e", "E"], do: 14 * :math.pow(16, position)
  defp get_value(letter, position) when letter in ["f", "F"], do: 15 * :math.pow(16, position)
  defp get_value(number, position), do: String.to_integer(number) * :math.pow(16, position)
end
