defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(string) do
    string
    |> String.graphemes()
    |> encoding("", 1)
  end

  defp encoding([current_letter | tail], initial_string, 1) when tail == [] do
    "#{initial_string <> current_letter}"
  end

  defp encoding([current_letter | tail], initial_string, letter_counter) when tail == [] do
    "#{initial_string <> to_string(letter_counter) <> current_letter}"
  end

  defp encoding([current_letter | tail], initial_string, letter_counter) do
    next_letter = Enum.at(tail, 0)

    cond do
      current_letter == next_letter ->
        encoding(tail, initial_string, letter_counter + 1)

      current_letter != next_letter and letter_counter > 1 ->
        encoding(tail, "#{initial_string <> to_string(letter_counter) <> current_letter}", 1)

      current_letter != next_letter and letter_counter <= 1 ->
        encoding(tail, "#{initial_string <> current_letter}", 1)
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    list_of_pairs = Regex.scan(~r/\d{0,2}[\w ]/u, string)

    Enum.reduce(list_of_pairs, "", fn [coded_pair], acc ->
      {amount, letter} = String.split_at(coded_pair, -1)

      case amount do
        "" ->
          acc <> letter

        _not_single ->
          quantity = String.to_integer(amount)
          acc <> append_letters(quantity, letter)
      end
    end)
  end

  defp append_letters(amount, letter) do
    Enum.reduce(1..amount, "", fn _x, acc -> acc <> letter end)
  end
end
