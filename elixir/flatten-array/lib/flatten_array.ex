defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten([[] | _tail]), do: []

  def flatten([head | tail]) do
    [head]
    |> get_flat(tail)
    |> Enum.reject(&is_nil/1)
  end

  defp get_flat(acc, []), do: acc

  defp get_flat(acc, [head | tail]) when not is_list(head) do
    get_flat(acc ++ [head], tail)
  end

  defp get_flat(acc, [head | tail]) when is_list(head) do
    get_flat(acc ++ get_flat([], head), tail)
  end
end
