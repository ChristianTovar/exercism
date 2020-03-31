defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: {:ok, integer()}
  def square(number) when number < 1 or number > 64,
    do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  def square(number) do
    result = get_amount(number)

    {:ok, result}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, integer()}
  def total do
    result = Enum.reduce(1..64, 0, &(&2 + get_amount(&1)))

    {:ok, result}
  end

  defp get_amount(number) do
    2
    |> :math.pow(number - 1)
    |> trunc()
  end
end
