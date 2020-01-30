defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @seconds_in_a_year 31_557_600

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    calculate_earth_years(planet, seconds)
  end

  defp seconds_in_a_year(seconds) do
    seconds / @seconds_in_a_year
  end

  defp calculate_earth_years(planet, seconds) do
    case planet do
      :mercury -> seconds_in_a_year(seconds) / 0.2408467
      :venus -> seconds_in_a_year(seconds) / 0.61519726
      :earth -> seconds_in_a_year(seconds)
      :mars -> seconds_in_a_year(seconds) / 1.8808158
      :jupiter -> seconds_in_a_year(seconds) / 11.862615
      :saturn -> seconds_in_a_year(seconds) / 29.447498
      :uranus -> seconds_in_a_year(seconds) / 84.016846
      :neptune -> seconds_in_a_year(seconds) / 164.79132
    end
  end
end
