defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.replace(~r"[^a-zA-Z0-9' ]", " ")
    |> String.replace(~r/([a-z])([A-Z])/, "\\1 \\2")
    |> String.split(" ")
    |> Enum.map(&String.at(&1, 0))
    |> Enum.join()
    |> String.upcase()
  end
end
