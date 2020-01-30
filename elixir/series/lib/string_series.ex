defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(string :: String.t(), size :: integer) :: list(String.t())
  def slices(string, size) when size <= 0 or size > length(string), do: []

  def slices(string, size) do
    string
    |> String.graphemes()
    |> slice(size)
    |> Enum.map(&(Enum.join(&1)))
  end

  defp slice([], _size) , do: []
  defp slice(list, size) when length(list) < size ,do: []
  defp slice([_head | tail] = list, size) ,do: [Enum.take(list, size)] ++ slice(tail, size)
end
