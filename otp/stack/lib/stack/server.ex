defmodule Stack.Server do
  use GenServer

  # Public API

  def start_link(stack) do
    GenServer.start_link(__MODULE__, stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  # def handle_call(:pop, _from, []) do
  #   {:reply, nil, []}
  # end

  def handle_call(:pop, _from, [head|tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, value}, stack) do
    {:noreply, [value|stack]}
  end

  def terminate(reason, state) do
    IO.puts "Reason: #{inspect reason}"
    IO.puts "State: #{inspect state}"
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "Current stack: #{inspect state}"}]]
  end
end
