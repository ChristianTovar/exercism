defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @students ~w(alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry)a

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    [top, bottom] = String.split(info_string, "\n")

    top_cups = set_cups(top)
    bottom_cups = set_cups(bottom)

    top_cups
    |> Enum.zip(bottom_cups)
    |> Enum.map(fn {a, b} -> format_cups(a, b) end)
    |> cups_into_map(Enum.sort(student_names), %{})
  end

  defp set_cups(cups) do
    cups
    |> String.graphemes()
    |> Enum.chunk_every(2)
  end

  defp format_cups([a, b], [c, d]),
    do: {cup_to_atom(a), cup_to_atom(b), cup_to_atom(c), cup_to_atom(d)}

  defp cup_to_atom("R"), do: :radishes
  defp cup_to_atom("C"), do: :clover
  defp cup_to_atom("G"), do: :grass
  defp cup_to_atom("V"), do: :violets

  defp cups_into_map(_cups, [], acc), do: acc

  defp cups_into_map([], [student | st], acc),
    do: cups_into_map([], st, Map.put(acc, student, {}))

  defp cups_into_map([cups | ct], [student | st], acc),
    do: cups_into_map(ct, st, Map.put(acc, student, cups))
end
