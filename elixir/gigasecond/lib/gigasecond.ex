defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          :calendar.datetime()

  def from({{_year, _month, _day}, {_hours, _minutes, _seconds}} = date) do
    date
    |> :calendar.datetime_to_gregorian_seconds()
    |> Kernel.+(1000000000)
    |> :calendar.gregorian_seconds_to_datetime()
  end
end
