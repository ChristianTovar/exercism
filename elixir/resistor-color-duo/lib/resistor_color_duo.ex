defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """

  @resistance %{
    black: "0",
    brown: "1",
    red: "2",
    orange: "3",
    yellow: "4",
    green: "5",
    blue: "6",
    violet: "7",
    grey: "8",
    white: "9"
  }

  @spec value(colors :: [atom]) :: integer
  def value(colors) do
    colors
    |> Enum.filter(&Map.has_key?(@resistance, &1))
    |> Enum.take(2)
    |> Enum.reduce("", &(&2 <> @resistance[&1]))
    |> String.to_integer()
  end
end
