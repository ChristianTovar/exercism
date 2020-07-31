defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(1), do: {:ok, :deficient}

  def classify(number) when number < 1,
    do: {:error, "Classification is only possible for natural numbers."}

  def classify(number) do
    number
    |> factors(2, [1])
    |> Enum.sum()
    |> determine_number(number)
  end

  defp factors(number, divisor, acc) when divisor > div(number, 2), do: acc

  defp factors(number, divisor, acc) when rem(number, divisor) == 0,
    do: factors(number, divisor + 1, [divisor | acc])

  defp factors(number, divisor, acc), do: factors(number, divisor + 1, acc)

  defp determine_number(aliquot, aliquot), do: {:ok, :perfect}
  defp determine_number(aliquot, number) when aliquot > number, do: {:ok, :abundant}
  defp determine_number(aliquot, number) when aliquot < number, do: {:ok, :deficient}
end
