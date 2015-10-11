defmodule StackSup.Server do
  use GenServer

  # Public API

  def start_link(initial) do
    GenServer.start_link(__MODULE__, initial, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  # GenServer implementation

  def handle_call(:pop, _from, [head|tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, value}, state) do
    {:noreply, [value|state]}
  end
end
