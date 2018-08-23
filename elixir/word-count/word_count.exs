defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(~r/[^\w\d-]|_/u)
    |> Enum.reject(&empty/1)
    |> Enum.reduce(%{}, &count_reducer/2)
  end

  def count_reducer(word, counts), do: Map.update(counts, word, 1, &(&1 + 1))
  def empty(""), do: true
  def empty(_), do: false
end
