defmodule Bob do
  def hey(input) do
    cond do
      shouting?(input) and question?(input) -> "Calm down, I know what I'm doing!"
      shouting?(input) -> "Whoa, chill out!"
      question?(input) -> "Sure."
      silence?(input) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end

  defp question?(input), do: String.ends_with?(input, "?")

  defp shouting?(input), do: has_letters?(input) and upper_case?(input)
  defp has_letters?(input), do: String.match?(input, ~r/[\p{L}]/)
  defp upper_case?(input), do: String.upcase(input) == input

  defp silence?(input), do: input |> String.trim() |> Kernel.==("")
end
