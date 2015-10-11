defmodule StackSup.Server do
  use GenServer

  # Public API

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  # GenServer implementation

  def init(stash_pid) do
    current_stash = StackSup.Stash.get_value stash_pid
    {:ok, {current_stash, stash_pid}}
  end

  def handle_call(:pop, _from, {[head|tail], stash_pid}) do
    {:reply, head, {tail, stash_pid}}
  end

  def handle_cast({:push, value}, {stack, stash_pid}) do
    {:noreply, {[value|stack], stash_pid}}
  end

  def terminate(_reason, {stack, stash_pid}) do
    StackSup.Stash.save_value stash_pid, stack
  end
end
