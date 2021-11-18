defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 0 and legacy? -> :unknown
      level == 0 -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 and legacy? -> :unknown
      level == 5 -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    level
    |> to_label(legacy?)
    |> send_alert(legacy?)
  end

  defp send_alert(:error, _legacy), do: :ops
  defp send_alert(:fatal, _legacy), do: :ops
  defp send_alert(:unknown, true), do: :dev1
  defp send_alert(:unknown, false), do: :dev2
  defp send_alert(_label, _legacy), do: nil
end
