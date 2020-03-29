defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: {:ok, integer()}
  def square(number) when number < 1 or number > 64,
    do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  def square(number) do
    result =
      2
      |> :math.pow(number - 1)
      |> trunc()

    {:ok, result}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, integer()}
  def total do
    result =
      1..64
      |> Enum.map(&square/1)
      |> Enum.map(fn {_, value} -> value end)
      |> Enum.sum()

    {:ok, result}
  end
end
