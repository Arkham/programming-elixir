# defmodule SequenceSup.Server do
#   use GenServer

#   @vsn "0"

#   # Public API

#   def start_link(stash_pid) do
#     GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
#   end

#   def next_number do
#     GenServer.call(__MODULE__, :next_number)
#   end

#   def increment_number(delta) do
#     GenServer.cast(__MODULE__, {:increment_number, delta})
#   end

#   # GenServer implementation

#   def init(stash_pid) do
#     current_number = SequenceSup.Stash.get_value stash_pid
#     {:ok, {current_number, stash_pid}}
#   end

#   def handle_call(:next_number, _from, {current_number, stash_pid}) do
#     {:reply, current_number, {current_number + 1, stash_pid}}
#   end

#   def handle_cast({:increment_number, delta}, {current_number, stash_pid}) do
#     {:noreply, {current_number + delta, stash_pid}}
#   end

#   def terminate(_reason, {current_number, stash_pid}) do
#     SequenceSup.Stash.save_value stash_pid, current_number
#   end
# end

defmodule SequenceSup.Server do
  use GenServer
  require Logger

  defmodule State, do: defstruct current_number: 0, stash_pid: nil, delta: 1

  @vsn "1"

  # Public API

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end

  # GenServer implementation

  def init(stash_pid) do
    state = SequenceSup.Stash.get_state stash_pid
    {:ok, %State{current_number: state.current_number, delta: state.delta, stash_pid: stash_pid}}
  end

  def handle_call(:next_number, _from, state) do
    {
      :reply,
      state.current_number,
      %{state | current_number: state.current_number + state.delta}
    }
  end

  def handle_cast({:increment_number, delta}, state) do
    {
      :noreply,
      %{state | current_number: state.current_number + delta, delta: delta}
    }
  end

  def terminate(_reason, state) do
    SequenceSup.Stash.save_state state.stash_pid, state
  end

  def code_change("0", old_state = { current_number, stash_pid }, _extra) do
    new_state = %State{current_number: current_number, stash_pid: stash_pid, delta: 1}
    Logger.info "Changing code from 0 to 1"
    Logger.info inspect(old_state)
    Logger.info inspect(new_state)
    {:ok, new_state}
  end
end
