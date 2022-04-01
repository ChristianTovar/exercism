defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, & &1.price)

  def with_missing_price(inventory), do: Enum.reject(inventory, & &1.price)

  def update_names(inventory, old_word, new_word),
    do: Enum.map(inventory, &replace_name(&1, old_word, new_word))

  def increase_quantity(%{quantity_by_size: quantity} = item, count),
    do: %{
      item
      | quantity_by_size: Map.new(quantity, fn {key, value} -> {key, value + count} end)
    }

  def total_quantity(%{quantity_by_size: quantity}),
    do: Enum.reduce(quantity, 0, fn {_key, value}, acc -> acc + value end)

  defp replace_name(%{name: name} = item, old_word, new_word),
    do: %{item | name: String.replace(name, old_word, new_word)}
end
