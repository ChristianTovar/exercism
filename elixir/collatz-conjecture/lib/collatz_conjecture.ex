defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  require Integer

  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(value) when is_integer(value) and value > 0, do: do_calc(value, 0)

  defp do_calc(1, acc), do: acc
  defp do_calc(value, acc) when Integer.is_even(value), do: do_calc(div(value, 2), acc + 1)
  defp do_calc(value, acc), do: do_calc(3 * value + 1, acc + 1)
end
