defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    x2 = :math.pow(x, 2)
    y2 = :math.pow(y, 2)

    x2
    |> Kernel.+(y2)
    |> :math.sqrt()
    |> calculate_score()
  end

  defp calculate_score(distance) when distance > 10, do: 0
  defp calculate_score(distance) when distance <= 10 and distance > 5, do: 1
  defp calculate_score(distance) when distance <= 5 and distance > 1, do: 5
  defp calculate_score(distance) when distance <= 1 and distance >= 0, do: 10
end
