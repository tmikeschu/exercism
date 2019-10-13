defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(<<x::utf8>> <> _) when <<x::utf8>> in ["]", "}", ")"], do: false

  def check_brackets(str) do
    pairs = %{"[" => "]", "{" => "}", "(" => ")"}

    str
    |> String.split("", trim: true)
    |> Enum.reduce_while([], fn el, acc ->
      case el do
        open when open in ~w([ { () ->
          {:cont, [open | acc]}

        close when close in ~w(] } \)) ->
          [h | tail] = acc

          if Map.get(pairs, h) == el do
            {:cont, tail}
          else
            {:halt, [:error]}
          end

        _ ->
          {:cont, acc}
      end
    end)
    |> Enum.empty?()
  end
end
