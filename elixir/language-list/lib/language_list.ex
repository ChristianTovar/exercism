defmodule LanguageList do
  def new(), do: []

  def add(list, language), do: [language | list]

  def remove([_head | tail]), do: tail

  def first([head | _tail]), do: head

  def count(list), do: count_elements(list, 0)

  def exciting_list?([]), do: false
  def exciting_list?(["Elixir" | _tail]), do: true
  def exciting_list?([_head | tail]), do: exciting_list?(tail)

  defp count_elements([], acc), do: acc
  defp count_elements([_head | tail], acc), do: count_elements(tail, acc + 1)
end
