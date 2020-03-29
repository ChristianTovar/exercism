defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l), do: count_elements(l, 0)

  @spec reverse(list) :: list
  def reverse([x]), do: [x]
  def reverse(l), do: reverse_list(l, [])

  @spec map(list, (any -> any)) :: list
  def map(list, f), do: for(l <- list, do: f.(l))

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, f), do: for(l <- list, f.(l), do: l)

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([h | t], acc, f), do: reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append(a, []), do: a
  def append([], b), do: b
  def append(a, b), do: concat([a, b])

  @spec concat([[any]]) :: [any]
  def concat(ll), do: do_concat(ll, [])

  defp count_elements([], acc), do: acc
  defp count_elements([_h | t], acc), do: count_elements(t, acc + 1)

  defp reverse_list([], acc), do: acc
  defp reverse_list([h | t], acc), do: reverse_list(t, [h | acc])

  defp do_concat([], acc), do: reverse(acc)
  defp do_concat([[] | list], acc), do: do_concat(list, acc)
  defp do_concat([[h | t] | list], acc), do: do_concat([t | list], [h | acc])
end
