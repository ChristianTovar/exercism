defmodule Allergies do
  @allergies ~W(eggs peanuts shellfish strawberries tomatoes chocolate pollen cats)

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(0), do: []

  def list(number), do: Enum.reduce(@allergies, [], &allergic(&1, number, &2))

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, "eggs"), do: Bitwise.band(flags, 1) != 0
  def allergic_to?(flags, "peanuts"), do: Bitwise.band(flags, 2) != 0
  def allergic_to?(flags, "shellfish"), do: Bitwise.band(flags, 4) != 0
  def allergic_to?(flags, "strawberries"), do: Bitwise.band(flags, 8) != 0
  def allergic_to?(flags, "tomatoes"), do: Bitwise.band(flags, 16) != 0
  def allergic_to?(flags, "chocolate"), do: Bitwise.band(flags, 32) != 0
  def allergic_to?(flags, "pollen"), do: Bitwise.band(flags, 64) != 0
  def allergic_to?(flags, "cats"), do: Bitwise.band(flags, 128) != 0

  defp allergic(allergy, number, acc) do
    case allergic_to?(number, allergy) do
      true -> [allergy | acc]
      false -> acc
    end
  end
end
