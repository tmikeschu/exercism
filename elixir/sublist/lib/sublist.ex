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
  def compare(a, b) do
    case {a, b} do
      {a, b} when a === b -> @equal
      {[], _} -> @sublist
      {_, []} -> @superlist
      {a, b} when length(a) < length(b) -> classify(b, a)
      {a, b} when length(a) > length(b) -> classify(a, b, @superlist)
      _ -> @unequal
    end
  end

  defp classify(a, b, label \\ @sublist) do
    if is_sublist?(a, b) do
      label
    else
      @unequal
    end
  end

  defp is_sublist?(a, b) do
    a
    |> Enum.chunk_every(length(b), 1)
    |> Enum.any?(fn chunk -> chunk === b end)
  end
end
