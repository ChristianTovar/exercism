defmodule SumOfMultiples do
  def to(limit, factors) when is_list(factors) do
    factors
    |> Enum.map(fn factor -> get_multiples(factor, limit - 1) end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.sum()
  end

  defp get_multiples(factor, limit) do
    limit..1
    |> Enum.filter(fn x -> rem(x, factor) == 0 end)
  end
end
