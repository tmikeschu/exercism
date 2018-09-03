defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search({integer}, integer) :: {:ok, integer} | :not_found
  def search({}, _key), do: :not_found

  def search(numbers, key) do
    half_index = numbers
                 |> tuple_size
                 |> Kernel./(2)
                 |> Float.floor
                 |> Kernel.trunc
    half = elem(numbers, half_index)

    if key == half do
      {:ok, half_index}
    else
      position = if key < half, do: :left, else: :right

      numbers
      |> Tuple.to_list
      |> take_or_drop(position).(half_index)
      |> Enum.find_index(& &1 == key)
      |> present_result({position, half_index})
    end
  end

  defp take_or_drop(:left), do: &Enum.take/2
  defp take_or_drop(:right), do: &Enum.drop/2

  defp present_result(nil, _), do: :not_found
  defp present_result(position, {:left, _half_index}) do
    {:ok, position}
  end
  defp present_result(position, {:right, half_index}) do
    {:ok, position + half_index}
  end
end
