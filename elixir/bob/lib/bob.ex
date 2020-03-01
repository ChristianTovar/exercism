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

  defp silence?(input), do: Regex.match?(~r/^\s*$/, input)

  defp asking?(input), do: Regex.match?(~r/^.+\?\s*$/, input)

  defp shouting?(input) do
    formated_input = String.replace(input, ~r/[^\p{L}]/u, "")
    Regex.match?(~r/^\p{Lu}+$/u, formated_input)
  end
end
