defmodule SequenceSup.Supervisor do
  use Supervisor

  def start_link(initial) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial])
    start_workers(sup, initial)
    result
  end

  def start_workers(sup, initial) do
    {:ok, stash} = Supervisor.start_child(
      sup,
      worker(SequenceSup.Stash, [%{current_number: initial, delta: 1}])
    )
    Supervisor.start_child(sup, supervisor(SequenceSup.SubSupervisor, [stash]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
