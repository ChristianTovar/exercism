defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number
    |> decompose()
    |> Enum.join()
  end

  defp decompose(number) when number > 1000 do
    biggest_digit = div(number, 1000) * 1000
    new_number = number - biggest_digit
    numeral = numerals(biggest_digit)
    [numeral | decompose(new_number)]
  end

  defp decompose(number) when number > 100 do
    biggest_digit = div(number, 100) * 100
    new_number = number - biggest_digit
    numeral = numerals(biggest_digit)
    [numeral | decompose(new_number)]
  end

  defp decompose(number) when number > 10 do
    biggest_digit = div(number, 10) * 10
    new_number = number - biggest_digit
    numeral = numerals(biggest_digit)
    [numeral | decompose(new_number)]
  end

  defp decompose(number), do: [numerals(number)]

  def numerals(number) when number == 3000, do: "MMM"
  def numerals(number) when number == 2000, do: "MM"
  def numerals(number) when number == 1000, do: "M"
  def numerals(number) when number == 900, do: "CM"
  def numerals(number) when number == 800, do: "DCCC"
  def numerals(number) when number == 700, do: "DCC"
  def numerals(number) when number == 600, do: "DCC"
  def numerals(number) when number == 500, do: "D"
  def numerals(number) when number == 400, do: "CD"
  def numerals(number) when number == 300, do: "CCC"
  def numerals(number) when number == 200, do: "CC"
  def numerals(number) when number == 100, do: "C"
  def numerals(number) when number == 90, do: "XC"
  def numerals(number) when number == 80, do: "LXXX"
  def numerals(number) when number == 70, do: "LXX"
  def numerals(number) when number == 60, do: "LX"
  def numerals(number) when number == 50, do: "L"
  def numerals(number) when number == 40, do: "XL"
  def numerals(number) when number == 30, do: "XXX"
  def numerals(number) when number == 20, do: "XX"
  def numerals(number) when number == 10, do: "X"
  def numerals(number) when number == 9, do: "IX"
  def numerals(number) when number == 8, do: "VIII"
  def numerals(number) when number == 7, do: "VII"
  def numerals(number) when number == 6, do: "VI"
  def numerals(number) when number == 5, do: "V"
  def numerals(number) when number == 4, do: "IV"
  def numerals(number) when number == 3, do: "III"
  def numerals(number) when number == 2, do: "II"
  def numerals(number) when number == 1, do: "I"
  def numerals(number) when number == 0, do: ""
end
