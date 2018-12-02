defmodule Benchmark do
  def measure(function) do
    function
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end

defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) when hour < 0 do
    leftover = negative_leftover(hour, 24)
    new(hour + 24 * leftover, minute)
  end

  def new(hour, minute) when minute < 0 do
    leftover = negative_leftover(minute, 60)
    new(hour - leftover, minute + 60 * leftover)
  end

  def new(hour, minute) do
    leftover = leftover(minute, 60)
    %Clock{hour: rem(hour + leftover, 24), minute: minute - leftover * 60}
  end

  defp leftover(total, base) do
    total
    |> Kernel./(base)
    |> trunc
    |> abs
  end

  defp negative_leftover(whole, base) do
    leftover(whole, base) + 1
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    Clock.new(hour, minute + add_minute)
  end
end

defimpl String.Chars, for: Clock do
  @spec to_string(%Clock{}) :: String.t()
  def to_string(%Clock{hour: hour, minute: minute}) do
    [hour, minute]
    |> Enum.map(&pad_zeros/1)
    |> Enum.join(":")
  end

  defp pad_zeros(int) do
    int
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end
end
