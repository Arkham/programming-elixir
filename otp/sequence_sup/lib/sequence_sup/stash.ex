defmodule SequenceSup.Stash do
  use GenServer

  # public API

  def start_link(initial) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, initial)
  end

  def get_value(stash_pid) do
    GenServer.call(stash_pid, :get_value)
  end

  def save_value(stash_pid, value) do
    GenServer.cast(stash_pid, {:save_value, value})
  end

  # GenServer implementation

  def handle_call(:get_value, _from, current_number) do
    {:reply, current_number, current_number}
  end

  def handle_cast({:save_value, value}, _current_number) do
    {:noreply, value}
  end
end
