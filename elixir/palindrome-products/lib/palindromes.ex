defmodule Palindromes do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    range = min_factor..max_factor
    products = get_products(range)

    small_product = get_palindrome(products)
    small_factors = factors(small_product, range)

    big_product =
      products
      |> Enum.reverse()
      |> get_palindrome()

    big_factors = factors(big_product, range)

    %{small_product => small_factors, big_product => big_factors}
  end

  defp get_products(range) do
    complete_products = for n <- range, m <- range, do: n * m

    complete_products
    |> Enum.uniq()
    |> Enum.sort(:desc)
  end

  defp get_palindrome([h | _t]) when h < 10, do: h

  defp get_palindrome([h | t]) do
    case h == reverse(h) do
      true -> h
      false -> get_palindrome(t)
    end
  end

  defp reverse(integer) do
    integer
    |> Integer.digits()
    |> Enum.reverse()
    |> Integer.undigits()
  end

  defp factors(number, products) do
    factors_list = for(x <- products, y <- products, x * y == number, do: [x, y])

    Enum.reduce(factors_list, [], &pair_in_list(&1, &2))
  end

  defp pair_in_list(pair, acc) do
    case pair in acc or Enum.reverse(pair) in acc do
      true -> acc
      false -> [pair | acc]
    end
  end
end
