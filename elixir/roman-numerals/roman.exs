defmodule Roman do
  @arabic_roman [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()

  def numerals(input) do
    numerals("", input)
  end

  @spec numerals(String.t(), pos_integer) :: String.t()
  def numerals(accumulator, 0), do: accumulator

  def numerals(accumulator, input) do
    @arabic_roman
    |> Enum.find(fn {arabic, _roman} -> input >= arabic end)
    |> reducer(accumulator, input)
  end

  @spec reducer({pos_integer, String.t()}, String.t(), pos_integer) :: String.t()
  defp reducer({arabic, roman}, accumulator, input),
    do: numerals(accumulator <> roman, input - arabic)
end
