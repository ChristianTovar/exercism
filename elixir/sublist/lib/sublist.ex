defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a == b, do: :equal
  def compare([], _b), do: :sublist
  def compare(_a, []), do: :superlist

  def compare(a, b) do
    size_a = length(a)
    size_b = length(b)

    cond do
      size_a < size_b or size_a == size_b -> is_inside?(a, b, :sublist, size_a)
      size_a > size_b -> is_inside?(b, a, :superlist, size_b)
    end
  end

  defp is_inside?(_a, [], _type, _size), do: :unequal

  defp is_inside?(a, [_hb | tb] = b, type, size) when length(a) <= length(b) do
    case Enum.take(b, size) do
      [] ->
        :unequal

      ^a ->
        type

      _different ->
        is_inside?(a, tb, type, size)
    end
  end

  defp is_inside?(_a, _b, _type, _size), do: :unequal
end
