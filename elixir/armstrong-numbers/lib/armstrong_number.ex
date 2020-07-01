defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) when number < 10, do: true

  def valid?(number) do
    list =
      number
      |> Integer.to_string()
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)

    size = length(list)

    Enum.reduce(list, 0, &(:math.pow(&1, size) + &2)) == number
  end
end
