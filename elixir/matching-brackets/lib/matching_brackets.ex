defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(""), do: true

  def check_brackets(string) do
    string
    |> String.replace(~r/[^(){}\[\]]/, "")
    |> String.graphemes()
    |> Enum.reduce([], fn value, acc -> stack(value, acc) end)
    |> balanced?()
  end

  defp stack(value, acc) when value in ["(", "[", ""] do
    [value | acc]
  end

  defp stack(value, [head | tail]) when value == "]" and head == "[" do
    tail
  end

  defp stack(value, [head | tail]) when value == "}" and head == "{" do
    tail
  end

  defp stack(value, [head | tail]) when value == ")" and head == "(" do
    tail
  end

  defp stack(value, acc) do
    [value | acc]
  end

  defp balanced?([]), do: true
  defp balanced?(_), do: false
end
