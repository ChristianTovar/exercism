defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise(ArgumentError, message: "the argument value is invalid")
  def nth(count), do: find_prime_number(count, 2, 0)

  defp find_prime_number(target, acc, target), do: acc - 1

  defp find_prime_number(target, acc, nth) do
    case prime?(acc) do
      true -> find_prime_number(target, acc + 1, nth + 1)
      false -> find_prime_number(target, acc + 1, nth)
    end
  end

  defp prime?(number), do: prime?(number, 2)
  defp prime?(number, number) when rem(number, number) == 0, do: true
  defp prime?(number, number), do: false
  defp prime?(number, divisor) when rem(number, divisor) == 0, do: false
  defp prime?(number, divisor), do: prime?(number, divisor + 1)
end
