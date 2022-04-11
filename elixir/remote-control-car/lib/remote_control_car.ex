defmodule RemoteControlCar do
  @enforce_keys [:nickname]

  defstruct battery_percentage: 100,
            distance_driven_in_meters: 0,
            nickname: nil

  def new(nickname \\ "none"), do: %__MODULE__{nickname: nickname}

  def display_distance(%__MODULE__{distance_driven_in_meters: distance}),
    do: "#{distance} meters"

  def display_battery(%__MODULE__{battery_percentage: 0}), do: "Battery empty"

  def display_battery(%__MODULE__{battery_percentage: percentage}),
    do: "Battery at #{percentage}%"

  def drive(
        %__MODULE__{battery_percentage: percentage, distance_driven_in_meters: distance} = car
      )
      when percentage > 0,
      do: %{car | battery_percentage: percentage - 1, distance_driven_in_meters: distance + 20}

  def drive(%__MODULE__{} = car), do: car
end
