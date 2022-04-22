defmodule CaptainsLog do
  @planetary_classes ~w(D H J K L M N R T Y)

  def random_planet_class, do: Enum.random(@planetary_classes)

  def random_ship_registry_number, do: "NCC-#{Enum.random(1000..9999)}"

  def random_stardate, do: :rand.uniform() * (42000.0 - 41000.0) + 41000.0

  def format_stardate(stardate) when is_float(stardate) do
    stardate
    |> Float.round(1)
    |> Float.to_string()
  end

  def format_stardate(_stardate), do: raise(ArgumentError, message: "no integers please...")
end
