defmodule ListOps do
  @spec count(list) :: non_neg_integer
  def count(l), do: reduce(l, 0, fn _, acc -> acc + 1 end)

  @spec reverse(list) :: list
  def reverse(l), do: reduce(l, [], &[&1 | &2])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: reduce(l, [], &[f.(&1) | &2]) |> reverse

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: reduce(l, [], filter_predicate(f)) |> reverse
  defp filter_predicate(f), do: &if(f.(&1), do: [&1 | &2], else: &2)

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([h | t], acc, f), do: reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append(x, y), do: reduce(reverse(x), y, &[&1 | &2])

  @spec concat([[any]]) :: [any]
  def concat(l), do: concat(l, [])
  defp concat([], acc), do: acc |> reverse
  defp concat([[] | t], acc), do: concat(t, acc)
  defp concat([[h | ht] | t], acc), do: concat([ht | t], [h | acc])
end
