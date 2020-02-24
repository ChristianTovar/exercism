defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a == b, do: :equal
  def compare([], _b), do: :sublist
  def compare(_a, []), do: :superlist

  def compare(a, b) do
    cond do
      length(a) < length(b) or length(a) == length(b) -> is_inside?(a, b, :sublist)
      length(a) > length(b) -> is_inside?(b, a, :superlist)
    end
  end

  defp is_inside?([ha | ta], [hb | tb], type) when ha === hb do
    is_inside?(ta, tb, type)
  end

  defp is_inside?([ha | _ta] = a, [hb | tb], type) when ha !== hb do
    is_inside?(a, tb, type)
  end

  defp is_inside?([ha | _ta], [hb | _tb], _type) when ha !== hb, do: :unequal
  defp is_inside?([], [], type), do: type
  defp is_inside?([], [_hn | _tb], type), do: type
  defp is_inside?([_ha | _ta], [], _type), do: :unequal
end
