defmodule Clock do
  defstruct hour: 0, minute: 0

  defimpl String.Chars, for: __MODULE__ do
    @spec to_string(Clock.t()) :: String.t()
    def to_string(%Clock{hour: h, minute: m}) when h < 10 and m < 10, do: "0#{h}:0#{m}"
    def to_string(%Clock{hour: h, minute: m}) when h < 10 and m > 10, do: "0#{h}:#{m}"
    def to_string(%Clock{hour: h, minute: m}) when h >= 10 and m < 10, do: "#{h}:0#{m}"
    def to_string(%Clock{hour: h, minute: m}), do: "#{h}:#{m}"
  end

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: %Clock{}
  def new(hour, minute) do
    hour
    |> set_hour()
    |> set_minute(minute)
  end

  @spec add(%Clock{}, any) :: %Clock{}
  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute), do: new(hour, minute + add_minute)

  defp set_hour(hour) when hour < 0, do: set_hour(hour + 24)
  defp set_hour(hour) when hour < 24, do: hour
  defp set_hour(hour), do: set_hour(hour - 24)

  defp set_minute(hour, minute) when minute < 0, do: set_minute(hour - 1, minute + 60)
  defp set_minute(hour, minute) when minute > 59, do: set_minute(hour + 1, minute - 60)
  defp set_minute(hour, minute), do: %Clock{hour: set_hour(hour), minute: minute}
end
