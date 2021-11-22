defmodule KitchenCalculator do
  def get_volume({_unit, value}), do: value

  def to_milliliter({:milliliter, value}), do: {:milliliter, value}
  def to_milliliter({:cup, value}), do: {:milliliter, value * 240}
  def to_milliliter({:fluid_ounce, value}), do: {:milliliter, value * 30}
  def to_milliliter({:teaspoon, value}), do: {:milliliter, value * 5}
  def to_milliliter({:tablespoon, value}), do: {:milliliter, value * 15}

  def from_milliliter({_unit, value}, :milliliter), do: {:milliliter, value}
  def from_milliliter({_unit, value}, :cup), do: {:cup, value / 240}
  def from_milliliter({_unit, value}, :fluid_ounce), do: {:fluid_ounce, value / 30}
  def from_milliliter({_unit, value}, :teaspoon), do: {:teaspoon, value / 5}
  def from_milliliter({_unit, value}, :tablespoon), do: {:tablespoon, value / 15}

  def convert({:teaspoon, value}, :tablespoon), do: {:tablespoon, value / 3}
  def convert({:cup, value}, :fluid_ounce), do: {:fluid_ounce, value * 8}
  def convert({:fluid_ounce, value}, :teaspoon), do: {:teaspoon, value * 6}
  def convert({:tablespoon, value}, :cup), do: {:cup, value / 16}
end
