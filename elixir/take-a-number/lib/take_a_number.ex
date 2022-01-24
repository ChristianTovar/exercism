defmodule TakeANumber do
  @initial_state 0

  def start() do
    spawn(fn -> wait_for_messages(@initial_state) end)
  end

  defp wait_for_messages(state) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        wait_for_messages(state)

      {:take_a_number, sender_pid} ->
        send(sender_pid, state + 1)
        wait_for_messages(state + 1)

      :stop ->
        Process.exit(self(), :bye)

      _unexpected_message ->
        wait_for_messages(state)
    end
  end
end
