defmodule BeerSong do
  @on_the_wall """
  CURRENT of beer on the wall, CURRENT of beer.
  """
  @next_on_the_wall ", NEXT of beer on the wall.\n"

  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    @on_the_wall
    |> String.replace("CURRENT", bottles(number))  
    |> String.capitalize
    |> Kernel.<>(pass_it(number))
    |> String.replace("IT", take(number))  
    |> Kernel.<>(@next_on_the_wall)
    |> String.replace("NEXT", bottles(number - 1))  
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

  @spec pluralize(String.t(), non_neg_integer) :: String.t()
  def pluralize(str, 1), do: "1 #{str}"
  def pluralize(str, count), do: "#{count} #{str}s"

  @spec bottles(non_neg_integer) :: String.t()
  defp bottles(-1), do: bottles(99)
  defp bottles(0), do: "no more bottles"
  defp bottles(number), do: pluralize("bottle", number)

  @spec take(non_neg_integer) :: String.t()
  defp take(1), do: "it"
  defp take(_), do: "one"

  @spec pass_it(non_neg_integer) :: String.t()
  defp pass_it(0), do: "Go to the store and buy some more"
  defp pass_it(_), do: "Take IT down and pass it around"
end
