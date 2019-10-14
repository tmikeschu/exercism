defmodule Sublist do
  @equal :equal
  @unequal :unequal
  @sublist :sublist
  @superlist :superlist
  @chunk_count 8

  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([], []), do: @equal
  def compare([], _), do: @sublist
  def compare(_, []), do: @superlist
  def compare(a, b) when a === b, do: @equal
  def compare(a, b) when length(a) < length(b), do: classify(b, a)
  def compare(a, b) when length(a) > length(b), do: classify(a, b, @superlist)
  def compare(_, _), do: @unequal

  defp classify(a, b, label \\ @sublist) do
    if is_sublist?(a, b) do
      label
    else
      @unequal
    end
  end

  defp is_sublist?(a, b) do
    a
    |> Enum.chunk_every(@chunk_count * length(b))
    |> Enum.map(&Task.async(fn -> has_matching_window?(&1, b) end))
    |> Enum.any?(&Task.await/1)
  end

  defp has_matching_window?(list, subject) do
    list
    |> windows(length(subject))
    |> Enum.any?(fn window -> window === subject end)
  end

  defp windows(list, count), do: windows(list, count, [])
  defp windows(list, count, acc) when length(list) < count, do: acc

  defp windows(list, count, acc) do
    list
    |> Enum.drop(1)
    |> windows(count, [Enum.slice(list, 0, count) | acc])
  end
end
