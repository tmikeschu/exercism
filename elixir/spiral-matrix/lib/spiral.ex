defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(dimension) do
    nil
    |> List.duplicate(dimension)
    |> List.duplicate(dimension)
    |> fill(dimension, 1, {0, 0}, :right)
  end

  @spec fill(
          grid :: list(list(integer | nil)),
          max :: integer,
          number :: integer,
          coordinate :: {integer, integer},
          direction :: :right | :down | :left | :up
        ) :: list(list(integer))
  def fill(grid, max, number, _, _) when max * max < number, do: grid

  def fill(grid, max, number, {x, y}, direction) do
    {next_x, next_y} = get_next_coordinate({x, y}, direction)

    {next_coordinate, next_direction} =
      case get(grid, next_y, next_x) do
        nil -> {{next_x, next_y}, direction}
        _ -> {get_next_coordinate({x, y}, turn(direction)), turn(direction)}
      end

    grid
    |> fill_grid(y, x, number)
    |> fill(max, number + 1, next_coordinate, next_direction)
  end

  defp get(list, y, x),
    do:
      list
      |> Enum.at(y, [])
      |> Enum.at(x, :error)

  defp turn(direction) do
    %{right: :down, down: :left, left: :up, up: :right}
    |> Map.get(direction, :right)
  end

  defp get_next_coordinate({x, y}, direction) do
    case direction do
      :up -> {x, y - 1}
      :down -> {x, y + 1}
      :left -> {x - 1, y}
      :right -> {x + 1, y}
    end
  end

  defp fill_grid(grid, y, x, number) do
    List.replace_at(
      grid,
      y,
      List.replace_at(Enum.fetch!(grid, y), x, number)
    )
  end
end
