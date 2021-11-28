defmodule BirdCount do
  @busy_day 5

  def today([]), do: nil
  def today([h | _t]), do: h

  def increment_day_count([]), do: [1]
  def increment_day_count([h | t]), do: [h + 1 | t]

  def has_day_without_birds?([0 | _t]), do: true
  def has_day_without_birds?([_any | t]), do: has_day_without_birds?(t)
  def has_day_without_birds?([]), do: false

  def total(list), do: sum(list)

  def busy_days(list) do
    list
    |> filter()
    |> count()
  end

  defp sum(list, acc \\ 0)
  defp sum([], acc), do: acc
  defp sum([h | t], acc), do: sum(t, acc + h)

  defp filter(list, acc \\ [])
  defp filter([], acc), do: acc
  defp filter([h | t], acc) when h >= @busy_day, do: filter(t, [h | acc])
  defp filter([_h | t], acc), do: filter(t, acc)

  defp count(list, acc \\ 0)
  defp count([], acc), do: acc
  defp count([_h | t], acc), do: count(t, acc + 1)
end
