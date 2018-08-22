defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    strand |> Enum.count(fn(s) -> s == nucleotide end)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """

  @base_histogram (
    @nucleotides
    |> Enum.zip(List.duplicate(0, length(@nucleotides)))
    |> Enum.into(%{})
  )

  @spec histogram([char]) :: map
  def histogram(strand) do
    strand |> Enum.reduce(@base_histogram, &historgram_reducer/2)
  end
  
  @type _histogram() :: %{ required(char) => number }

  @spec historgram_reducer(char, _histogram()) :: _histogram()
  defp historgram_reducer(el, acc) do
    increment_key(acc, el)
  end

  def increment_key(acc, key), do: acc |> Map.update(key, 0, &(&1 + 1))
end
