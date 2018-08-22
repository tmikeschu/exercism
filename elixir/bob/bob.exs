defmodule Strings do
  def has_letters?(input), do: String.match?(input, ~r/[\p{L}]/)
  def is_upper_case?(input), do: String.upcase(input) == input
end

defmodule Fn do
  def all_true(bools), do: bools |> Enum.all?(&identity/1)
  def apply_fn(input), do: fn f -> f.(input) end
  def identity(x), do: x
  def juxt(input, fns), do: fns |> Enum.map(apply_fn(input))
end

defmodule Bob do
  import Strings
  import Fn

  @conditions ~w(question shout silent)a
  @false_conditions @conditions
                    |> Enum.zip(List.duplicate(false, length(@conditions)))
                    |> Enum.into(%{})

  def hey(input) do
    input
    |> String.trim()
    |> with_conditions
    |> question
    |> shout
    |> silence
    |> response
  end

  defp with_conditions("" <> input),
    do: Map.merge(%{input: input}, @false_conditions)

  defp silence(%{input: input} = types), do: %{types | silent: input == ""}

  defp question(%{input: input} = types),
    do: %{types | question: String.ends_with?(input, "?")}

  defp shout(%{input: input} = types),
    do: %{types | shout: is_shouting?(input)}

  defp is_shouting?(input) do
    input
    |> juxt([&is_upper_case?/1, &has_letters?/1])
    |> all_true
  end

  defp response(%{shout: true, question: true}),
    do: "Calm down, I know what I'm doing!"

  defp response(%{question: true}), do: "Sure."
  defp response(%{shout: true}), do: "Whoa, chill out!"
  defp response(%{silent: true}), do: "Fine. Be that way!"
  defp response(_), do: "Whatever."
end
