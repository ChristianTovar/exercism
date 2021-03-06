defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  defstruct mp: 1, w: 0, d: 0, l: 0, p: 0
  @scoreboard "Team                           | MP |  W |  D |  L |  P\n"

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> check_format()
    |> calculate_tournament_results()
    |> print_tournament_result()
  end

  defp check_format(input), do: Enum.filter(input, &match_valid_inputs/1)

  defp match_valid_inputs(input), do: input =~ ~r/^\w*\s\w*;\w*\s\w*;(win|loss|draw)$/

  defp calculate_tournament_results(input), do: Enum.reduce(input, %{}, &add_match_results/2)

  defp add_match_results(string, map) do
    [team_a, team_b, result] = String.split(string, ";")

    map
    |> increase_played_matches(team_a)
    |> increase_played_matches(team_b)
    |> set_match_result(team_a, team_b, result)
  end

  defp increase_played_matches(map, team),
    do:
      Map.update(map, team, %Tournament{}, fn %Tournament{mp: mp} = map -> %{map | mp: mp + 1} end)

  defp set_match_result(map, team_a, team_b, "win") do
    map
    |> increase_winner_points(team_a)
    |> increase_wins(team_a)
    |> increase_losses(team_b)
  end

  defp set_match_result(map, team_a, team_b, "loss") do
    map
    |> increase_winner_points(team_b)
    |> increase_wins(team_b)
    |> increase_losses(team_a)
  end

  defp set_match_result(map, team_a, team_b, "draw") do
    map
    |> increase_drawer_points(team_a)
    |> increase_drawer_points(team_b)
    |> increase_draws(team_a)
    |> increase_draws(team_b)
  end

  defp increase_winner_points(map, team),
    do: Map.update!(map, team, fn %Tournament{p: p} = map -> %{map | p: p + 3} end)

  defp increase_drawer_points(map, team),
    do: Map.update!(map, team, fn %Tournament{p: p} = map -> %{map | p: p + 1} end)

  defp increase_wins(map, team),
    do: Map.update!(map, team, fn %Tournament{w: w} = map -> %{map | w: w + 1} end)

  defp increase_losses(map, team),
    do: Map.update!(map, team, fn %Tournament{l: l} = map -> %{map | l: l + 1} end)

  defp increase_draws(map, team),
    do: Map.update!(map, team, fn %Tournament{d: d} = map -> %{map | d: d + 1} end)

  defp print_tournament_result(map) do
    map
    |> Enum.map(& &1)
    |> Enum.sort_by(fn {_, map} -> map.p end, :desc)
    |> Enum.reduce(@scoreboard, fn {team, %{mp: mp, w: w, d: d, l: l, p: p}}, acc ->
      acc <> "#{team}" <> "#{insert_spaces(team)}" <> "|  #{mp} |  #{w} |  #{d} |  #{l} |  #{p}\n"
    end)
    |> String.trim()
  end

  def insert_spaces(team) do
    length = String.length(team)
    String.duplicate(" ", 31 - length)
  end
end
