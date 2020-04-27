defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(?A), do: "A\n"

  def build_shape(letter) do
    initial_spacing = letter - ?A

    upper_diamond(?A, initial_spacing, -1, "") <>
      lower_diamond(letter - 1, 1, -1 + 2 * (initial_spacing - 1), "")
  end

  defp upper_diamond(_, -1, _, acc), do: acc

  defp upper_diamond(letter, side_spacing, middle_spacing, acc) do
    new_acc = acc <> set_row(letter, side_spacing, middle_spacing) <> "\n"

    upper_diamond(letter + 1, side_spacing - 1, middle_spacing + 2, new_acc)
  end

  defp lower_diamond(?@, _, _, acc), do: acc

  defp lower_diamond(letter, side_spacing, middle_spacing, acc) do
    new_acc = acc <> set_row(letter, side_spacing, middle_spacing) <> "\n"

    lower_diamond(letter - 1, side_spacing + 1, middle_spacing - 2, new_acc)
  end

  defp set_row(?A, spacing, _),
    do: String.duplicate(" ", spacing) <> "A" <> String.duplicate(" ", spacing)

  defp set_row(letter, side_spacing, middle_spacing),
    do:
      String.duplicate(" ", side_spacing) <>
        List.to_string([letter]) <>
        String.duplicate(" ", middle_spacing) <>
        List.to_string([letter]) <> String.duplicate(" ", side_spacing)
end
