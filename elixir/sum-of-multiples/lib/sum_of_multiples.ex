defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    is_evenly_divisible = fn x ->
      Enum.any?(factors, &(Integer.mod(x, &1) == 0))
    end

    2..(limit - 1)
    |> Enum.to_list()
    |> Enum.filter(is_evenly_divisible)
    |> Enum.sum()
  end
end
