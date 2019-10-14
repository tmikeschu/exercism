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
    cond do
      a === b -> @equal
      length(a) <= length(b) && is_sublist?(b, a) -> @sublist
      length(a) > length(b) && is_sublist?(a, b) -> @superlist
      true -> @unequal
    end
  end

  defp is_sublist?(a, b) when length(a) < length(b), do: false
  defp is_sublist?(a, b), do: Enum.take(a, length(b)) === b || is_sublist?(tl(a), b)
end
