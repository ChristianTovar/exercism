defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    with true <- characters_free?(raw) do
      raw
      |> remove_characters()
      |> check_number_format()
      |> remove_country_code()
    else
      false -> "0000000000"
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    raw
    |> remove_characters()
    |> remove_country_code()
    |> check_number_format()
    |> extract_area_code()
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    raw
    |> remove_characters()
    |> check_number_format()
    |> remove_country_code()
    |> print()
  end

  defp characters_free?(number), do: !Regex.match?(~r/[a-z]/, number)

  defp remove_characters(number), do: String.replace(number, ~r/[^0-9]/, "")

  defp check_number_format(number) do
    case Regex.match?(~r/^1?[2-9][0-9]{2}[2-9][0-9]{6}$/, number) do
      true -> number
      false -> "0000000000"
    end
  end

  defp remove_country_code(number) do
    case String.starts_with?(number, "1") do
      true -> String.slice(number, 1..-1)
      false -> number
    end
  end

  defp extract_area_code(number), do: String.slice(number, 0..2)

  defp print(number) do
    %{"area" => area, "first_local" => first_local, "second_local" => second_local} =
      Regex.named_captures(~r/(?<area>\d{3})(?<first_local>\d{3})(?<second_local>\d{4})/, number)

    "(#{area}) #{first_local}-#{second_local}"
  end
end
