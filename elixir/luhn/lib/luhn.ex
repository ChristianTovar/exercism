defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    case letters_free?(number) do
      true ->
        check_number(number)

      false ->
        false
    end
  end

  defp letters_free?(number), do: number =~ ~r/^[\d\s]*$/

  defp check_number(number) do
    number
    |> remove_characters()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> reject_initial_zero()
    |> double_digits()
    |> divisible?()
  end

  defp remove_characters(string), do: String.replace(string, ~r/[^0-9]/, "")

  defp reject_initial_zero([0 | tail]), do: tail
  defp reject_initial_zero(list), do: list

  defp double_digits([]), do: false
  defp double_digits([_]), do: false

  defp double_digits(list) do
    list
    |> Enum.map_every(2, &substract(&1 * 2))
    |> Enum.sum()
  end

  defp substract(number) when number > 9, do: number - 9
  defp substract(number), do: number

  defp divisible?(number) when rem(number, 10) == 0, do: true
  defp divisible?(_), do: false
end
