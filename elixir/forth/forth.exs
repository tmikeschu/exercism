defmodule Forth do
  @type stack :: [String.t() | integer()]
  @opaque evaluator :: %{stack: stack, words: %{String.t() => [String.t()]}}

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    %{stack: [], words: %{}}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, s),
    do:
      s
      |> String.split(~r/ ?; ?/, trim: true)
      |> Enum.reduce(ev, &eval_reducer/2)

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(%{stack: stack}),
    do:
      stack
      |> Enum.reverse()
      |> Enum.join(" ")

  defp eval_reducer(s, %{words: words} = acc) do
    Map.merge(
      acc,
      eval_unit(s, words)
    )
  end

  defp eval_unit(s, words) do
    case Regex.run(~r/^: ([^\s]*) (.*)/, s) do
      [_, word, value] ->
        %{
          words:
            add_word(
              words,
              word,
              String.split(value, " ")
            )
        }

      _ ->
        %{stack: reduce_stack(s, words)}
    end
  end

  defp add_word(words, word, value) do
    case Integer.parse(word) do
      {_, ""} -> raise Forth.InvalidWord
      _ -> Map.put(words, word, value)
    end
  end

  defp reduce_stack(s, words) do
    s
    |> String.split(~r/[\b\s \x00\x01]+/)
    |> Enum.flat_map(&Map.get(words, &1, [&1]))
    |> Enum.map(&sanitize/1)
    |> Enum.reduce([], &Forth.StackReducer.reduce/2)
  end

  defp sanitize(x) do
    case Integer.parse(x) do
      {int, _} -> int
      :error -> String.downcase(x)
    end
  end

  defmodule StackReducer do
    @doc """
    Takes an element from an input string and 
    """

    @type stack :: [String.t() | integer()]
    @spec reduce(String.t(), stack) :: stack
    def reduce(x, stack) when is_number(x), do: [x | stack]

    def reduce("/", [0, _ | _]), do: raise(Forth.DivisionByZero)

    def reduce(x, [h, n | tail]) when x in ~w(+ - * /) do
      [
        apply(Kernel, String.to_atom(x), [n, h])
        |> Kernel./(1)
        |> Float.floor()
        |> round
        | tail
      ]
    end

    def reduce(x, stack)
        when length(stack) == 0 or (length(stack) == 1 and x in ~w(swap over)),
        do: raise(Forth.StackUnderflow)

    def reduce(x, stack) when x in ~w(dup drop swap over),
      do: apply(Forth.StackOps, String.to_atom(x), [stack])

    def reduce(_, _), do: raise(Forth.UnknownWord)
  end

  defmodule StackOps do
    @doc """
    Duplicates the head of the list and prepends it to the list
    """
    def dup([h | t]), do: [h | [h | t]]

    @doc """
    Drops the head of the list
    """
    def drop([_ | t]), do: t

    @doc """
    Takes the head and the "neck" and prepends them reversed
    """
    def swap([h, n | t]), do: [n | [h | t]]

    @doc """
    Takes the head and the "neck" and prepends the neck
    """
    def over([h, n | t]), do: [n | [h | [n | t]]]
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
