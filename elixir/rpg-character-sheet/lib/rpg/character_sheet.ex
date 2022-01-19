defmodule RPG.CharacterSheet do
  def welcome, do: IO.puts("Welcome! Let's fill out your character sheet together.")

  def ask_name, do: gets("What is your character's name?\n")

  def ask_class, do: gets("What is your character's class?\n")

  def ask_level() do
    "What is your character's level?\n"
    |> gets()
    |> String.to_integer()
  end

  def run() do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()

    IO.inspect(%{name: name, class: class, level: level}, label: "Your character")
  end

  defp gets(string) do
    string
    |> IO.gets()
    |> String.replace_trailing("\n", "")
  end
end
