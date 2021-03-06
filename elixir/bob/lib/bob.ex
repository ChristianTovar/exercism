defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      asking?(input) and shouting?(input) -> "Calm down, I know what I'm doing!"
      asking?(input) -> "Sure."
      shouting?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp silence?(input), do: String.trim(input) == ""

  defp asking?(input) do
    input
    |> String.trim()
    |> String.ends_with?("?")
  end

  defp shouting?(input) do
    case String.upcase(input) != String.downcase(input) do
      true -> input == String.upcase(input)
      false -> false
    end
  end
end
