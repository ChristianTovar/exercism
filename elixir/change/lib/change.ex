defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(_coins, 0), do: {:ok, []}
  def generate(_coins, target) when target < 0, do: {:error, "cannot change"}

  def generate(coins, target) do
    coins
    |> Enum.reverse()
    |> get_all_possible_changes([], target)
    |> Enum.sort()
    |> Enum.at(-1)
  end

  defp get_all_possible_changes([], acc, _target), do: acc

  defp get_all_possible_changes([h | t] = coins, acc, target),
    do: get_all_possible_changes(t, [calculate_change(coins, [h], h, target) | acc], target)

  defp calculate_change(_, coins, target, target), do: {:ok, coins}
  defp calculate_change([], _coins, _acc, _target), do: {:error, "cannot change"}

  defp calculate_change([coin | _t], coins, acc, target) when acc + coin == target,
    do: {:ok, [coin | coins]}

  defp calculate_change([coin], coins, acc, target) when acc + coin <= target,
    do: calculate_change([coin], [coin | coins], acc + coin, target)

  defp calculate_change([coin | t] = list, coins, acc, target) when acc + coin < target do
    case Enum.any?(t, &(acc + coin + &1 <= target)) do
      true -> calculate_change(list, [coin | coins], acc + coin, target)
      false -> calculate_change(t, coins, acc, target)
    end
  end

  defp calculate_change([coin | t], coins, acc, target) when acc + coin > target,
    do: calculate_change(t, coins, acc, target)
end
