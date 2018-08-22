defmodule SecretHandshake do
  import Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
    |> with_sequence
    |> wink
    |> double_blink
    |> close_your_eyes
    |> jump
    |> reverse
    |> Map.get(:sequence)
    |> Enum.reverse
  end

  defp with_sequence(code), do: %{ code: code, sequence: [] }

  defp wink(set), do: update_sequence(set, &is_wink?/1, "wink")
  defp is_wink?(code), do: has_bits?(code, 0b1)

  defp double_blink(set), do: update_sequence(set, &is_double_blink?/1, "double blink")
  defp is_double_blink?(code), do: has_bits?(code, 0b10)

  defp close_your_eyes(set), do: update_sequence(set, &is_close_your_eyes?/1, "close your eyes")
  defp is_close_your_eyes?(code), do: has_bits?(code, 0b100)

  defp jump(set), do: update_sequence(set, &is_jump?/1, "jump")
  defp is_jump?(code), do: has_bits?(code, 0b1000)

  defp reverse(set), do: update_sequence(set, &should_reverse?/1, &(Enum.reverse(&1)))
  defp should_reverse?(code), do: has_bits?(code, 0b10000)

  defp update_sequence(%{ code: code } = set, predicate, "" <> unit), do: Map.update(
    set,
    :sequence,
    [], 
    &(if predicate.(code), do: [unit | &1], else: &1)
  )

  defp update_sequence(%{ code: code } = set, predicate, unit) when is_function(unit), do: Map.update(
    set,
    :sequence,
    [], 
    &(if predicate.(code), do: unit.(&1), else: &1)
  )

  defp has_bits?(code, bits), do: (code |> band(bits) |> Kernel.==(bits))
end
