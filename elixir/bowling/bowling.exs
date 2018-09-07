defmodule Bowling do
  import Integer, only: [is_even: 1]

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start, do: %{scores: [[0], []], frame: 1}

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t()
  def roll(_, n) when n < 0, do: {:error, "Negative roll is invalid"}

  def roll(%{frame: f, scores: [[h, t | _] | _]}, _)
      when f > 22
      when f > 20 and h + t < 10 do
    {:error, "Cannot roll after game is over"}
  end

  def roll(%{frame: f, scores: [[h | _] | _]}, n)
      when n > 10
      when is_even(f) and h != 10 and n + h > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end

  def roll(%{frame: f} = g, roll) do
    if is_even(f) do
      score_even_frame(g, roll)
    else
      score_odd_frame(g, roll)
    end
  end

  defp score_even_frame(%{scores: [h | [th | tail]], frame: f}, roll) do
    prev = if prev_strike?(th, f), do: [roll | th], else: th
    %{scores: [[roll | h] | [prev | tail]], frame: f + 1}
  end

  defp score_odd_frame(%{scores: [h | [th | tail]], frame: f}, roll) do
    frame_inc = if roll == 10 && f < 20, do: 2, else: 1
    prev = if prev_strike?(h, f) || prev_spare?(h, f), do: [roll | h], else: h
    prev_prev = if prev_strike?(th, f, :penultimate), do: [roll | th], else: th

    %{scores: [[roll] | [prev | [prev_prev | tail]]], frame: f + frame_inc}
  end

  defp prev_spare?(pins, f) when f > 20 or length(pins) != 2, do: false
  defp prev_spare?([x, y], _f), do: x + y == 10

  defp prev_strike?(_, f, pos \\ :last)
  defp prev_strike?(_, f, :last) when f > 20, do: false
  defp prev_strike?(_, f, :penultimate) when f > 21, do: false
  defp prev_strike?([x], _, _), do: x == 10
  defp prev_strike?([_, x], _, _), do: x == 10
  defp prev_strike?(_, _, _), do: false

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @not_end_of_game {:error, "Score cannot be taken until the end of the game"}

  @spec score(any) :: integer | String.t()
  def score(%{frame: f}) when f < 20, do: @not_end_of_game

  def score(%{frame: f, scores: [[a, b] | _]})
      when f == 21 and a + b == 10,
      do: @not_end_of_game

  def score(%{frame: f, scores: [[h | _], [prev_h | _] | _]})
      when f == 21 and h == 10
      when f == 22 and h + prev_h > 19,
      do: @not_end_of_game

  def score(%{scores: fs}), do: Enum.reduce(fs, 0, &(Enum.sum(&1) + &2))
end
