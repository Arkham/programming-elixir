defmodule StackSup.Stash do
  use GenServer

  def start_link(initial) do
    GenServer.start_link(__MODULE__, initial)
  end

  def get_value(stash_pid) do
    GenServer.call(stash_pid, :get_value)
  end

  def save_value(stash_pid, value) do
    GenServer.cast(stash_pid, {:save_value, value})
  end

  def handle_call(:get_value, _from, initial) do
    {:reply, initial, initial}
  end

  def handle_cast({:save_value, value}, _initial) do
    {:noreply, value}
  end
end
