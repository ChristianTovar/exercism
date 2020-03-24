defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  # @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    right = tuple_size(numbers) - 1

    get_number(numbers, key, 0, right)
  end

  defp get_number(_numbers, _key, left, right) when left > right, do: :not_found

  defp get_number(numbers, key, left, right) do
    mid = div(left + right, 2)

    cond do
      key == elem(numbers, mid) -> {:ok, mid}
      key < elem(numbers, mid) -> get_number(numbers, key, left, mid - 1)
      key > elem(numbers, mid) -> get_number(numbers, key, mid + 1, right)
    end
  end
end
