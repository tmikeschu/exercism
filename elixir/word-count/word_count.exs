defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    inc = &(&1 + 1)
    reducer = fn el, acc -> Map.update(acc, el, 1, inc) end

    sentence
    |> String.downcase()
    |> String.replace(~r/_/, " ")
    |> String.replace(~r/[:;!@#$%^&().,]/, "")
    |> String.replace(~r/\s\s+/, " ")
    |> String.split(" ")
    |> Enum.reduce(%{}, reducer)
  end
end
