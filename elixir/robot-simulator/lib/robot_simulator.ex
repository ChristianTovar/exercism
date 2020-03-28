defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  defstruct [:direction, :position]
  @directions [:north, :east, :south, :west]

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    with {true, :valid_direction} <- check_direction(direction),
         {true, :valid_position} <- check_position(position) do
      %RobotSimulator{direction: direction, position: position}
    else
      {false, :invalid_direction} -> {:error, "invalid direction"}
      {false, :invalid_position} -> {:error, "invalid position"}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    case instructions =~ ~r/^[ARL]*$/ do
      true ->
        instructions
        |> String.graphemes()
        |> Enum.reduce(robot, &execute_instruction/2)

      false ->
        {:error, "invalid instruction"}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%RobotSimulator{direction: value}), do: value

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%RobotSimulator{position: value}), do: value

  defp check_direction(direction) when direction in @directions, do: {true, :valid_direction}
  defp check_direction(_), do: {false, :invalid_direction}

  defp check_position({x, y}) when is_integer(x) and is_integer(y), do: {true, :valid_position}
  defp check_position(_), do: {false, :invalid_position}

  defp execute_instruction("A", %RobotSimulator{direction: :north, position: {x, y}} = robot),
    do: %{robot | position: {x, y + 1}}

  defp execute_instruction("A", %RobotSimulator{direction: :south, position: {x, y}} = robot),
    do: %{robot | position: {x, y - 1}}

  defp execute_instruction("A", %RobotSimulator{direction: :west, position: {x, y}} = robot),
    do: %{robot | position: {x - 1, y}}

  defp execute_instruction("A", %RobotSimulator{direction: :east, position: {x, y}} = robot),
    do: %{robot | position: {x + 1, y}}

  defp execute_instruction("L", %RobotSimulator{direction: :north} = robot),
    do: %{robot | direction: :west}

  defp execute_instruction("L", %RobotSimulator{direction: :south} = robot),
    do: %{robot | direction: :east}

  defp execute_instruction("L", %RobotSimulator{direction: :west} = robot),
    do: %{robot | direction: :south}

  defp execute_instruction("L", %RobotSimulator{direction: :east} = robot),
    do: %{robot | direction: :north}

  defp execute_instruction("R", %RobotSimulator{direction: :north} = robot),
    do: %{robot | direction: :east}

  defp execute_instruction("R", %RobotSimulator{direction: :south} = robot),
    do: %{robot | direction: :west}

  defp execute_instruction("R", %RobotSimulator{direction: :west} = robot),
    do: %{robot | direction: :north}

  defp execute_instruction("R", %RobotSimulator{direction: :east} = robot),
    do: %{robot | direction: :south}
end
