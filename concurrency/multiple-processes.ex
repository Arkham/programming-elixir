defmodule MultipleProcesses do
  import :timer, only: [sleep: 1]

  def node(pid) do
    receive do
      _msg ->
        send pid, "bye"
        exit(:boom)
        # raise "Error"
    end
  end

  def run do
    child = spawn(MultipleProcesses, :node, [self])
    # child = spawn_link(MultipleProcesses, :node, [self])
    # {child, _ref} = spawn_monitor(MultipleProcesses, :node, [self])

    send child, "HELLO"

    sleep 500

    receive_messages
  end

  def receive_messages do
    receive do
      msg ->
        IO.puts inspect msg
        receive_messages
    after 1000 ->
    end
  end
end

MultipleProcesses.run
