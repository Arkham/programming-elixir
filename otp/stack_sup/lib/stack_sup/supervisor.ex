defmodule StackSup.Supervisor do
  use Supervisor

  def start_link(initial) do
    result = {:ok, pid} = Supervisor.start_link(__MODULE__, initial)
    start_workers(pid, initial)
    result
  end

  def start_workers(sup, initial) do
    {:ok, stash} = Supervisor.start_child(sup, worker(StackSup.Stash, [initial]))
    Supervisor.start_child(sup, supervisor(StackSup.SubSupervisor, [stash]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
