defmodule BracketPush do
  @openers ~w([ { ()
  @closers ~w(] } \))
  @matches ~w([] {} (\))

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.split("", trim: true)
    |> Enum.reduce_while([], &reducer/2)
    |> Enum.empty?()
  end

  defp reducer(_, [close]) when close in @closers, do: {:halt, [:error]}

  defp reducer(open, acc) when open in @openers, do: {:cont, [open | acc]}

  defp reducer(close, [head | tail]) when close in @closers do
    case head <> close do
      match when match in @matches -> {:cont, tail}
      _ -> {:halt, [:error]}
    end
  end

  defp reducer(_, acc), do: {:cont, acc}
end
