defmodule StackSup do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    {:ok, _pid} = StackSup.Supervisor.start_link([0, 0, 7])
  end
end
