defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    layers = String.split(path, ".")

    extract_value(data, layers)
  end

  def get_in_path(data, path) do
    layers = String.split(path, ".")

    get_in(data, layers)
  end

  defp extract_value(data, [h]), do: data[h]
  defp extract_value(data, [h | t]), do: extract_value(data[h], t)
end
