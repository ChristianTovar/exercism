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
    with false <- Regex.match?(~r/[a-z]/, raw) do
      raw
      |> remove_characters()
      |> String.graphemes()
      |> remove_country_code()
      |> check_area_code()
    else
      true -> "0000000000"
    end
  end

  defp remove_characters(number), do: String.replace(number, ~r/[^0-9]/, "")

  defp remove_country_code([code | tail] = number) when length(number) == 11 and code == "1",
    do: Enum.join(tail)

  defp remove_country_code([code | _tail] = number) when length(number) == 11 and code != "1",
    do: "0000000000"

  defp remove_country_code(number) when length(number) < 10,
    do: "0000000000"

  defp remove_country_code(number), do: Enum.join(number)

  defp check_area_code(number) do
    case Regex.match?(~r/^[2-9]\d{9}$/, number) do
      true -> number

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
  end
end
