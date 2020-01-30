defmodule ResistorColor do
  @moduledoc false

  @colors ~w(black  brown  red  orange  yellow  green  blue  violet  grey white)

  @spec colors() :: list(String.t())
  def colors do
    @colors
  end

  @spec code(String.t()) :: integer()
  def code(color) do
    Enum.find_index(@colors, &(&1 == color))
  end

  @spec filter(list :: [integer()]) :: [integer()]
  def filter(list) do
    list
    |> Enum.with_index()
    |> Enum.reject(fn {_value, index} -> rem(index, 2) == 0 end)
    |> Enum.map(fn {value, _index} -> value end)
  end
end
