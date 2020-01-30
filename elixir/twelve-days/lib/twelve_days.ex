defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @presents [
    "a Partridge in a Pear Tree.",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

  @position ~w(first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth)

  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    presents_list =
      @presents
      |> Enum.take(number)
      |> join_presents()

    position = Enum.at(@position, number - 1)
    "On the #{position} day of Christmas my true love gave to me: #{presents_list}"
  end

  defp join_presents([first_present]), do: first_present

  defp join_presents([first_present | remaining_presents]) do
    presents =
      remaining_presents
      |> Enum.reverse()
      |> Enum.join(", ")

    "#{presents}, and #{first_present}"
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
