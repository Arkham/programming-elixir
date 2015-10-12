defmodule SequenceSup do
  use Application

  def start(_type, _args) do
    {:ok, _pid} = SequenceSup.Supervisor.start_link(Application.get_env(:sequence_sup, :initial_number))
  end
end
