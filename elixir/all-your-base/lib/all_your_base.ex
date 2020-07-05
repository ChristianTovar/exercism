defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list | nil
  def convert([], _base_a, _base_b), do: nil
  def convert(_digits, base_a, base_b) when base_a < 2 or base_b < 2, do: nil

  def convert(digits, base_a, 10) do
    position = length(digits) - 1

    to_decimal(digits, position, base_a, 0)
  end

  def convert(digits, 10, base_b), do: from_decimal(Integer.undigits(digits), base_b, [])

  defp to_decimal([], _position, _base, acc), do: Integer.digits(acc)

  defp to_decimal([h | t], position, 2, acc) when h in [0, 1],
    do: to_decimal(t, position - 1, 2, acc + h * trunc(:math.pow(2, position)))

  defp to_decimal([h | _t], _position, 2, _acc) when h not in [0, 1], do: nil

  defp to_decimal([h | t], position, base, acc),
    do: to_decimal(t, position - 1, base, acc + h * trunc(:math.pow(base, position)))

  defp from_decimal(0, _base, []), do: [0]
  defp from_decimal(0, _base, acc), do: acc

  defp from_decimal(remainder, base, acc),
    do: from_decimal(div(remainder, base), base, [rem(remainder, base) | acc])
end
