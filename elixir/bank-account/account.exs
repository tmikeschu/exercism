defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  defstruct balance: 0

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    case Agent.start_link(fn -> %BankAccount{} end) do
      {:ok, pid} -> pid
      _ -> :error
    end
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: :ok
  def close_bank(account) do
    Agent.stop(account)
  end

  @spec check_closed(pid, (() -> any)) :: any | {:error, :account_closed}
  defp check_closed(account, if_open) do
    if Process.alive?(account) do
      if_open.()
    else
      {:error, :account_closed}
    end
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) do
    check_closed(account, fn -> Agent.get(account, & &1.balance) end)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: :ok | {:error, :account_closed}
  def update(account, amount) do
    check_closed(account, fn -> Agent.update(account, inc_balance(amount)) end)
  end

  @spec inc_balance(number) :: (%BankAccount{} -> %BankAccount{})
  defp inc_balance(amount) do
    fn %BankAccount{} = ba ->
      %{ba | balance: ba.balance + amount}
    end
  end
end
