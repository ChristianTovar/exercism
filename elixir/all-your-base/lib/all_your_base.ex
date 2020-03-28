defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b) do
    size = Enum.count(digits) - 1

    digits
    |> Enum.zip(size..0)
    |> Enum.map(fn {bit, value} -> bit * pow(base_a, value) end)
    |> sum(base_b)
    |> format(base_b)
  end

  def convert(digits, 10, 2) do
  end

  defp pow(x, y), do: :math.pow(x, y) |> trunc()

  defp sum(values, 2), do: values
  defp sum(values, _), do: Enum.sum(values)

  defp format(value, 10) when value < 10, do: [value]

  defp format(value, 10) do
    value
    |> Integer.to_string()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  defp format(value, _), do: value

  defp divide() do
    
  end

  defp divide(number, acc) do
    result = div(number, 2)
    remainder = rem(number, 2)
    divide(result, [remainder | acc])
  end
end
