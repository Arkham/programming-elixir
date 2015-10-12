defmodule StackSup do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    {:ok, _pid} = StackSup.Supervisor.start_link(Application.get_env(:stack_sup, :initial_stack))
  end
end
