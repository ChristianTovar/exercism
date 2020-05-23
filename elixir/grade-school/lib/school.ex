defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t(), integer) :: map
  def add(db, name, grade), do: Map.update(db, grade, [name], &[name | &1])

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t()]
  def grade(db, grade), do: return_grade(db[grade])

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t()]}]
  def sort(db) do
    db
    |> Map.keys()
    |> Enum.map(&sort_children(db, &1))
  end

  defp return_grade(nil), do: []
  defp return_grade(list), do: list

  defp sort_children(db, grade), do: {grade, Enum.sort(db[grade])}
end
