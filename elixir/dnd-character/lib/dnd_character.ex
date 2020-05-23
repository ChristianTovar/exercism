defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    score
    |> Kernel.-(10)
    |> Kernel./(2)
    |> Float.floor()
    |> trunc()
  end

  @spec ability :: pos_integer()
  def ability do
    1..4
    |> Enum.map(fn _ -> :rand.uniform(6) end)
    |> Enum.sort()
    |> add_rolls()
  end

  @spec character :: t()
  def character do
    %{constitution: value} = character = create_random_character()
    %__MODULE__{character | hitpoints: 10 + modifier(value)}
  end

  defp create_random_character,
    do: %__MODULE__{
      strength: ability(),
      dexterity: ability(),
      constitution: ability(),
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability()
    }

  defp add_rolls([_smallest | tail]), do: Enum.sum(tail)
end
