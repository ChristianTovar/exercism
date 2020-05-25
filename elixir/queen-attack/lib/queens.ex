defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]
  @colors [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts) do
    with true <- valid_color?(opts),
         true <- valid_position?(opts) do
      Enum.into(opts, %{})
    else
      false -> raise(ArgumentError)
    end
  end

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

  defp valid_color?([{color1, _}, {color2, _}]) when color1 in @colors and color2 in @colors,
    do: true

  defp valid_color?([{color, _}]) when color in [:white, :black], do: true
  defp valid_color?(_), do: false

  defp valid_position?([{_, {x1, y1}}, {_, {x2, y2}}])
       when x1 >= 0 and x1 < 8 and y1 >= 0 and y1 < 8 and x2 >= 0 and x2 < 8 and y2 >= 0 and
              y2 < 8 and (x1 != x2 or y1 != y2),
       do: true

  defp valid_position?([{_, {x, y}}]) when x >= 0 and x < 8 and y >= 0 and y < 8, do: true
  defp valid_position?(_), do: false

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
