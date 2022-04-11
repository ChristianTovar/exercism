defmodule Newsletter do
  def read_emails(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  def open_log(path), do: File.open!(path, [:write])

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    pid = open_log(log_path)

    emails_path
    |> read_emails()
    |> Enum.map(&send_email(pid, &1, send_fun))

    close_log(pid)
  end

  defp send_email(pid, email, send_fun),
    do: if(send_fun.(email) == :ok, do: log_sent_email(pid, email))
end
