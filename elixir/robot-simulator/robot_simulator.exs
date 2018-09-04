defmodule RobotSimulator do
  @valid_directions ~w(north east south west)a
  @valid_instructions ~w(A L R)a

  @type instruction :: :L | :R | :A
  @type direction :: :north | :east | :south | :west
  @type coordinate :: {integer, integer}
  @type robot :: {direction, coordinate}
  @type error :: {:error, String.t()}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position :: coordinate) :: robot | error
  def create(d \\ :north, p \\ {0, 0})

  def create(d, _) when d not in @valid_directions do
    {:error, "invalid direction"}
  end

  def create(_, p)
      when not is_tuple(p)
      when tuple_size(p) != 2
      when not (is_number(elem(p, 0)) and is_number(elem(p, 1))) do
    {:error, "invalid position"}
  end

  def create(d, p), do: {d, p}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, String.t()) :: robot
  def simulate(robot, instructions) do
    instructions
    |> String.split("", trim: true)
    |> Enum.map(&String.to_atom/1)
    |> Enum.reduce_while(robot, &robot_reducer/2)
  end

  @spec robot_reducer(instruction, robot) :: {:cont, robot} | {:halt, error}
  defp robot_reducer(el, _) when el not in @valid_instructions do
    {:halt, {:error, "invalid instruction"}}
  end

  defp robot_reducer(:A, {facing, coordinates}) do
    coordinates
    |> advance(facing)
    |> (&{facing, &1}).()
    |> reducer_cont
  end

  defp robot_reducer(left_or_right, {facing, coordinates}) do
    @valid_directions
    |> Enum.find_index(&(&1 == facing))
    |> turn(left_or_right)
    |> (&{&1, coordinates}).()
    |> reducer_cont
  end

  defp reducer_cont(x), do: {:cont, x}

  @spec advance(coordinate, direction) :: coordinate
  defp advance({x, y}, facing) do
    case facing do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end
  end

  @spec turn(integer, instruction) :: direction
  defp turn(index, :L) do
    Enum.fetch!(@valid_directions, index - 1)
  end

  defp turn(index, :R) do
    case Enum.fetch(@valid_directions, index + 1) do
      :error -> :north
      {:ok, facing} -> facing
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({d, _}), do: d

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position({_, p}), do: p
end
