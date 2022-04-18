# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  use Agent

  def start(opts \\ [name: __MODULE__]), do: Agent.start_link(fn -> {[], 0} end, opts)

  def list_registrations(pid) do
    {registrations, _} = Agent.get(pid, & &1)

    registrations
  end

  def register(pid, register_to) do
    id = current_id(pid) + 1
    plot = %Plot{plot_id: id, registered_to: register_to}
    Agent.update(pid, fn {registrations, _} -> {[plot | registrations], id} end)

    plot
  end

  def release(pid, plot_id) do
    {registrations, current_id} = get_state(pid)
    updated_registrations = Enum.reject(registrations, fn %Plot{plot_id: id} -> id == plot_id end)

    Agent.update(pid, fn _ -> {updated_registrations, current_id} end)
  end

  def get_registration(pid, plot_id) do
    pid
    |> list_registrations()
    |> Enum.find({:not_found, "plot is unregistered"}, fn %Plot{plot_id: id} -> id == plot_id end)
  end

  defp current_id(pid) do
    {_, last_id} = Agent.get(pid, & &1)

    last_id
  end

  defp get_state(pid), do: Agent.get(pid, & &1)
end
