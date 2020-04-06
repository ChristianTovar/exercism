defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: []

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem), do: [elem | list]

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list), do: get_length(list, 0)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?([]), do: true
  def empty?(_), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek([]), do: {:error, :empty_list}
  def peek([h | _t]), do: {:ok, h}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail([]), do: {:error, :empty_list}
  def tail([_h | t]), do: {:ok, t}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop([]), do: {:error, :empty_list}
  def pop([h | t]), do: {:ok, h, t}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list), do: list

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list), do: from_list(list)

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: do_reverse(list, [])

  defp get_length([], acc), do: acc
  defp get_length([_h | t], acc), do: get_length(t, acc + 1)

  defp do_reverse([], acc), do: acc
  defp do_reverse([h | t], acc), do: do_reverse(t, [h | acc])
end
