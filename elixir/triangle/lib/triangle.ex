defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0,
    do: {:error, "all side lengths must be positive"}

  def kind(a, b, c) do
    [max | remaining] = Enum.sort([a, b, c], :desc)
    remaining_sum = Enum.sum(remaining)

    if remaining_sum > max do
      check_kind(a, b, c)
    else
      {:error, "side lengths violate triangle inequality"}
    end
  end

  defp check_kind(a, a, a), do: {:ok, :equilateral}
  defp check_kind(a, b, c) when a == b or b == c or a == c, do: {:ok, :isosceles}
  defp check_kind(_a, _b, _c), do: {:ok, :scalene}
end
