defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """
  use GenServer

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  def start_link(), do: GenServer.start_link(__MODULE__, 0)

  @impl true
  def init(_state), do: {:ok, %{balance: 0}}

  @impl true
  def handle_call(_, _from, {:error, :account_closed} = state), do: {:reply, state, state}

  def handle_call(:balance, _from, %{balance: amount} = state), do: {:reply, amount, state}

  def handle_call({:update, extra_cash}, _from, %{balance: amount} = state),
    do: {:reply, :ok, %{state | balance: amount + extra_cash}}

  def handle_call(:close, _from, _state), do: {:reply, :ok, {:error, :account_closed}}

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = start_link()
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account), do: GenServer.call(account, :close)

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account), do: GenServer.call(account, :balance)

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount), do: GenServer.call(account, {:update, amount})
end
