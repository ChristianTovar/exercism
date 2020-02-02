defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.replace(~r/[^a-zA-z]/, "")
    |> String.graphemes()
    |> Enum.frequencies()
    |> repeated?()
  end

  defp repeated?(map) do
    case Enum.at(map, 0) do
      nil ->
        true

      {key, value} when value <= 1 ->
        map
        |> Map.drop([key])
        |> repeated?()

      _repeated ->
        false
    end
  end
end
