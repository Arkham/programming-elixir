defmodule SequenceSup do
  use Application

  def start(_type, _args) do
    {:ok, _pid} = SequenceSup.Supervisor.start_link(123)
  end
end
