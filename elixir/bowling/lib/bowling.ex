defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @strike 10
  @max_frames 10

  @spec start() :: any
  def start, do: []

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t()
  def roll([[a, b] | _] = throws, _) when a + b < @strike and length(throws) == @max_frames,
    do: {:error, "Cannot roll after game is over"}

  def roll([[_a, _b], [@strike] | _] = throws, _) when length(throws) > @max_frames,
    do: {:error, "Cannot roll after game is over"}

  def roll([[_], [a, b] | _] = throws, _) when a + b == @strike and length(throws) > @max_frames,
    do: {:error, "Cannot roll after game is over"}

  def roll(_, roll) when roll < 0, do: {:error, "Negative roll is invalid"}
  def roll(_, roll) when roll > @strike, do: {:error, "Pin count exceeds pins on the lane"}
  def roll([], roll), do: [[roll]]
  def roll([[10] | _] = throws, roll), do: [[roll] | throws]
  def roll([[_throw_1, _throw_2] | _] = throws, roll), do: [[roll] | throws]

  def roll([[throw_1] | _], roll) when throw_1 + roll > @strike,
    do: {:error, "Pin count exceeds pins on the lane"}

  def roll([[throw_1] | tail], roll), do: [[throw_1, roll] | tail]

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t()
  def score(throws) when length(throws) < @max_frames,
    do: {:error, "Score cannot be taken until the end of the game"}

  def score(throws) do
    throws
    |> Enum.reverse()
    |> calculate_score(0, 1)
  end

  defp calculate_score([[@strike]], _score, @max_frames),
    do: {:error, "Score cannot be taken until the end of the game"}

  defp calculate_score([[@strike], [@strike]], _score, @max_frames),
    do: {:error, "Score cannot be taken until the end of the game"}

  defp calculate_score([[@strike], [a, b]], score, @max_frames), do: score + @strike + a + b
  defp calculate_score([[@strike], [a], [b]], score, @max_frames), do: score + @strike + a + b

  defp calculate_score([[a, b]], _score, @max_frames) when a + b == @strike,
    do: {:error, "Score cannot be taken until the end of the game"}

  defp calculate_score([[a, b], [@strike]], score, @max_frames) when a + b == @strike,
    do: score + a + b + @strike

  defp calculate_score([[a]], score, _), do: score + a
  defp calculate_score([], score, _), do: score

  defp calculate_score([[@strike] | [[a, b] | _] = tail], score, frame),
    do: calculate_score(tail, score + @strike + a + b, frame + 1)

  defp calculate_score([[@strike] | [[@strike], [a, _b] | _] = tail], score, frame),
    do: calculate_score(tail, score + 2 * @strike + a, frame + 1)

  defp calculate_score([[@strike] | [[@strike], [@strike] | _] = tail], score, frame),
    do: calculate_score(tail, score + 3 * @strike, frame + 1)

  defp calculate_score([[a, b] | [[@strike] | _] = tail], score, frame) when a + b == @strike,
    do: calculate_score(tail, score + 2 * @strike, frame + 1)

  defp calculate_score([[a, b] | [[c, _d] | _] = tail], score, frame) when a + b == @strike,
    do: calculate_score(tail, score + a + b + c, frame + 1)

  defp calculate_score([[a, b] | tail], score, frame),
    do: calculate_score(tail, score + a + b, frame + 1)
end
