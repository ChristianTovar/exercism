defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    formated_isbn = remove_characters(isbn)

    case valid_format?(formated_isbn) do
      false ->
        false

      true ->
        check_formula_result(formated_isbn)
    end
  end

  defp valid_format?(isbn) do
    cond do
      isbn =~ ~r/^[0-9]{9}[0-9 | X]$/ -> true
      isbn =~ ~r/./ -> false
    end
  end

  defp remove_characters(isbn), do: String.replace(isbn, "-", "")

  defp check_formula_result(isbn) do
    result =
      isbn
      |> String.graphemes()
      |> Enum.zip(10..1)
      |> Enum.reduce(0, &multiply_isbn/2)

    cond do
      rem(result, 11) == 0 -> true
      rem(result, 11) != 0 -> false
    end
  end

  defp multiply_isbn({"X", y}, acc), do: acc + 10 * y
  defp multiply_isbn({x, y}, acc), do: acc + String.to_integer(x) * y
end
