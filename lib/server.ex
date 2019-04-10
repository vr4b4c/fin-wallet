defmodule Server do
  def start(callback_module, state) do
    spawn(Server, :loop, [callback_module, state])
  end

  def call(server_pid, command) do
    send(server_pid, {command, self()})

    receive do
      r -> r
    end
  end

  def loop(callback_module, state) do
    receive do
      {command, caller_pid} ->
        {response, state} = apply(callback_module, :handle_command, [command, caller_pid, state])

        send(caller_pid, response)
        loop(callback_module, state)
    end
  end
end
