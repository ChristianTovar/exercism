defmodule OcrNumbers do
  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, charlist()}
  def convert(input) do
    input
    |> Enum.map(&String.graphemes/1)
    |> do_convertion("")
  end

  defp do_convertion([[], [], [], []], acc), do: {:ok, acc}

  defp do_convertion([[], [], [], [] | tail], acc),
    do: do_convertion(tail, acc <> ",")

  defp do_convertion([a, b, c, d | tail], acc) do
    {ha, ta} = Enum.split(a, 3)
    {hb, tb} = Enum.split(b, 3)
    {hc, tc} = Enum.split(c, 3)
    {hd, td} = Enum.split(d, 3)

    case obtain_digit([ha, hb, hc, hd]) do
      {:ok, digit} -> do_convertion([ta, tb, tc, td | tail], acc <> digit)
      {:error, message} -> {:error, message}
    end
  end

  defp do_convertion(_, _), do: {:error, 'invalid line count'}

  defp obtain_digit(list) do
    list
    |> Enum.map(&Enum.join/1)
    |> convert_digit()
  end

  defp convert_digit([
         " _ ",
         "| |",
         "|_|",
         "   "
       ]),
       do: {:ok, "0"}

  defp convert_digit([
         "   ",
         "  |",
         "  |",
         "   "
       ]),
       do: {:ok, "1"}

  defp convert_digit([
         " _ ",
         " _|",
         "|_ ",
         "   "
       ]),
       do: {:ok, "2"}

  defp convert_digit([
         " _ ",
         " _|",
         " _|",
         "   "
       ]),
       do: {:ok, "3"}

  defp convert_digit([
         "   ",
         "|_|",
         "  |",
         "   "
       ]),
       do: {:ok, "4"}

  defp convert_digit([
         " _ ",
         "|_ ",
         " _|",
         "   "
       ]),
       do: {:ok, "5"}

  defp convert_digit([
         " _ ",
         "|_ ",
         "|_|",
         "   "
       ]),
       do: {:ok, "6"}

  defp convert_digit([
         " _ ",
         "  |",
         "  |",
         "   "
       ]),
       do: {:ok, "7"}

  defp convert_digit([
         " _ ",
         "|_|",
         "|_|",
         "   "
       ]),
       do: {:ok, "8"}

  defp convert_digit([
         " _ ",
         "|_|",
         " _|",
         "   "
       ]),
       do: {:ok, "9"}

  defp convert_digit([_, _, _, _] = input), do: calculate_spaces(input)

  defp calculate_spaces(input) do
    spaces = Enum.reduce(input, 0, &(&2 + String.length(&1)))

    case multiple_of_3?(spaces) do
      true -> {:ok, "?"}
      false -> {:error, 'invalid column count'}
    end
  end

  defp multiple_of_3?(input) when rem(input, 3) == 0, do: true
  defp multiple_of_3?(_), do: false
end
