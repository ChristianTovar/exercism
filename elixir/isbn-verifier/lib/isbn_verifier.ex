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
    case valid_format?(isbn) do
      false ->
        false

      true ->
        isbn
        |> remove_characters()
        |> check_formula_result()
    end
  end

  defp valid_format?(isbn), do: Regex.match?(~r/[0-9]-[0-9]{3}-[0-9]{5}-[0-9 | X]/, isbn)

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
