defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  @colors [:white, :black]

  defstruct [:white, :black]
  defguardp is_valid_color(color) when color in @colors
  defguardp is_valid_position(x, y) when x >= 0 and x < 8 and y >= 0 and y < 8

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new([{color, {x, y}}] = opts) when is_valid_color(color) and is_valid_position(x, y),
    do: Enum.into(opts, %{})

  def new([{color1, {x1, y1}}, {color2, {x2, y2}}] = opts)
      when is_valid_color(color1) and is_valid_color(color2) and is_valid_position(x1, y1) and
             is_valid_position(x2, y2) and (x1 != x2 or y1 != y2),
      do: Enum.into(opts, %{})

  def new(_), do: raise(ArgumentError)

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    board = for x <- 0..7, y <- 0..7, do: check_position({x, y}, queens)

    board
    |> Enum.join()
    |> String.trim()
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%{black: {x1, y1}, white: {x2, y2}}),
    do: abs(y2 - y1) == abs(x2 - x1) or x1 == x2 or y1 == y2

  def can_attack?(_), do: false

  defp check_position({_, 7} = input, %{black: black, white: white})
       when input != black and input != white,
       do: "_\n"

  defp check_position(input, %{black: black, white: white})
       when input != black and input != white,
       do: "_ "

  defp check_position({_, 7} = input, %{black: input}), do: "B\n"
  defp check_position(input, %{black: input}), do: "B "

  defp check_position({_, 7} = input, %{white: input}), do: "w\n"
  defp check_position(input, %{white: input}), do: "W "

  defp check_position({_, 7}, _), do: "_\n"
  defp check_position(_, _), do: "_ "
end
