defmodule Username do
  @lowercase ?a..?z
  @special_characters [?_, ?ö, ?ä, ?ü, ?ß]

  def sanitize(username) do
    username
    |> Enum.filter(&(&1 in @lowercase or &1 in @special_characters))
    |> Enum.map(&if &1 == ?ü, do: [?u, ?e], else: &1)
    |> Enum.map(&if &1 == ?ö, do: [?o, ?e], else: &1)
    |> Enum.map(&if &1 == ?ä, do: [?a, ?e], else: &1)
    |> Enum.map(&if &1 == ?ß, do: [?s, ?s], else: &1)
    |> List.flatten()
  end
end
