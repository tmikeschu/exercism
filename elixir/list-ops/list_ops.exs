defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_ | t]), do: 1 + count(t)

  @spec reverse(list) :: list
  def reverse([]), do: []
  def reverse([h | t]), do: reverse(t, [h])
  def reverse([h], r), do: [h | r]
  def reverse([h | t], r), do: reverse(t, [h | r])

  @spec map(list, (any -> any)) :: list
  def map([], f), do: []
  def map([h | t], f), do: [f.(h) | map(t, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], f), do: []
  def filter([h | t], f), do: if(f.(h), do: [h | filter(t, f)], else: filter(t, f))

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, f), do: acc
  def reduce([h | t], acc, f), do: reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append([], []), do: []
  def append([], x), do: x
  def append(x, []), do: x
  def append([xh | xt], y), do: [xh | append(xt, y)]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([[] | t]), do: concat(t)
  def concat([[h | ht] | t]), do: [h | concat([ht | t])]
end
