defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(1), do: []
  def factors_for(number) when number < 4, do: [number]
  def factors_for(number), do: calculate_factors(number, 2, [])

  defp calculate_factors(divisor, divisor, acc), do: Enum.reverse([divisor | acc])

  defp calculate_factors(number, divisor, acc) when rem(number, divisor) == 0,
    do: calculate_factors(div(number, divisor), divisor, [divisor | acc])

  defp calculate_factors(number, divisor, acc), do: calculate_factors(number, divisor + 1, acc)
end
