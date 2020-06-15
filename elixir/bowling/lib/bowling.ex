defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start, do: []

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t()
  def roll([[a, b] | _] = throws, _) when a + b < 10 and length(throws) == 10,
    do: {:error, "Cannot roll after game is over"}

  def roll([[_a, _b], [10] | _] = throws, _) when length(throws) == 11,
    do: {:error, "Cannot roll after game is over"}

  def roll([[_], [a, b] | _] = throws, _) when a + b == 10 and length(throws) == 11,
    do: {:error, "Cannot roll after game is over"}

  def roll(_, roll) when roll < 0, do: {:error, "Negative roll is invalid"}
  def roll(_, roll) when roll > 10, do: {:error, "Pin count exceeds pins on the lane"}
  def roll([], roll), do: [[roll]]
  def roll([[10] | _] = throws, roll), do: [[roll] | throws]
  def roll([[_throw_1, _throw_2] | _] = throws, roll), do: [[roll] | throws]

  def roll([[throw_1] | _], roll) when throw_1 + roll > 10,
    do: {:error, "Pin count exceeds pins on the lane"}

  def roll([[throw_1] | tail], roll), do: [[throw_1, roll] | tail]

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t()
  def score(throws) when length(throws) < 10,
    do: {:error, "Score cannot be taken until the end of the game"}

  def score(throws) do
    throws
    |> Enum.reverse()
    |> calculate_score(0, 1)
  end

  defp calculate_score([[10]], _score, 10),
    do: {:error, "Score cannot be taken until the end of the game"}

  defp calculate_score([[10], [10]], _score, 10),
    do: {:error, "Score cannot be taken until the end of the game"}

  defp calculate_score([[10], [a, b]], score, 10), do: score + 10 + a + b
  defp calculate_score([[10], [a], [b]], score, 10), do: score + 10 + a + b

  defp calculate_score([[a, b]], _score, 10) when a + b == 10,
    do: {:error, "Score cannot be taken until the end of the game"}

  defp calculate_score([[a, b], [10]], score, 10) when a + b == 10, do: score + a + b + 10
  defp calculate_score([[a]], score, _), do: score + a
  defp calculate_score([], score, _), do: score

  defp calculate_score([[10] | [[a, b] | _] = tail], score, frame),
    do: calculate_score(tail, score + 10 + a + b, frame + 1)

  defp calculate_score([[10] | [[10], [a, _b] | _] = tail], score, frame),
    do: calculate_score(tail, score + 20 + a, frame + 1)

  defp calculate_score([[10] | [[10], [10] | _] = tail], score, frame),
    do: calculate_score(tail, score + 30, frame + 1)

  defp calculate_score([[a, b] | [[10] | _] = tail], score, frame) when a + b == 10,
    do: calculate_score(tail, score + 20, frame + 1)

  defp calculate_score([[a, b] | [[c, _d] | _] = tail], score, frame) when a + b == 10,
    do: calculate_score(tail, score + a + b + c, frame + 1)

  defp calculate_score([[a, b] | tail], score, frame),
    do: calculate_score(tail, score + a + b, frame + 1)
end
