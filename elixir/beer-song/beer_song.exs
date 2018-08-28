defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    [&on_the_wall/1, &of_beer/1, &pass_it_around/1, &next_on_the_wall/1]
    |> Enum.map(& &1.(number))
    |> Enum.join("")
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  def lyrics(), do: lyrics(99..0)
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @spec on_the_wall(number) :: String.t()
  def on_the_wall(number),
    do: "#{number |> get_bottles |> String.capitalize()} of beer on the wall, "

  @spec of_beer(number) :: String.t()
  def of_beer(number), do: "#{number |> get_bottles} of beer.\n"

  @spec pass_it_around(non_neg_integer) :: String.t()
  defp pass_it_around(0), do: "Go to the store and buy some more"
  defp pass_it_around(1), do: "Take it down and pass it around"
  defp pass_it_around(_), do: "Take one down and pass it around"

  @spec next_on_the_wall(number) :: String.t()
  def next_on_the_wall(number) do
    bottles = number |> dec |> get_bottles
    ", #{bottles} of beer on the wall.\n"
  end

  @spec dec(number) :: number
  def dec(x), do: x - 1

  @spec pluralize(String.t(), non_neg_integer) :: String.t()
  def pluralize(str, 1), do: "1 #{str}"
  def pluralize(str, count), do: "#{count} #{str}s"

  @spec get_bottles(non_neg_integer) :: String.t()
  defp get_bottles(-1), do: get_bottles(99)
  defp get_bottles(0), do: "no more bottles"
  defp get_bottles(number), do: pluralize("bottle", number)
end
