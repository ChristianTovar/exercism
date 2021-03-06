defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}

  defstruct map: %{}

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    unique_set = Enum.into(enumerable, %{}, &{&1, :ok})

    %CustomSet{map: unique_set}
  end

  @spec empty?(t) :: boolean
  def empty?(%CustomSet{map: set}) when map_size(set) < 1, do: true
  def empty?(%CustomSet{map: _}), do: false

  @spec contains?(t, any) :: boolean
  def contains?(%CustomSet{map: set}, element), do: Map.has_key?(set, element)

  @spec subset?(t, t) :: boolean
  def subset?(%CustomSet{map: set_1}, %CustomSet{map: set_2}) do
    keys_1 = Map.keys(set_1)
    keys_2 = Map.keys(set_2)

    case keys_1 -- keys_2 do
      [] -> true
      _ -> false
    end
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(%CustomSet{map: set_1}, %CustomSet{map: set_2}) do
    keys_1 = Map.keys(set_1)
    keys_2 = Map.keys(set_2)

    case keys_1 -- keys_2 do
      ^keys_1 -> true
      _ -> false
    end
  end

  @spec equal?(t, t) :: boolean
  def equal?(%CustomSet{map: set_1}, %CustomSet{map: set_2}), do: set_1 == set_2

  @spec add(t, any) :: t
  def add(%CustomSet{map: set}, element) do
    updated_set = Map.put_new(set, element, :ok)

    %CustomSet{map: updated_set}
  end

  @spec intersection(t, t) :: t
  def intersection(%CustomSet{map: set_1}, %CustomSet{map: set_2}) do
    keys_2 = Map.keys(set_2)

    set_1
    |> Map.keys()
    |> Enum.filter(&(&1 in keys_2))
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(%CustomSet{map: set_1}, %CustomSet{map: set_2}) do
    keys_2 = Map.keys(set_2)

    set_1
    |> Map.keys()
    |> Enum.reject(&(&1 in keys_2))
    |> new()
  end

  @spec union(t, t) :: t
  def union(%CustomSet{map: set_1}, %CustomSet{map: set_2}) do
    keys_1 = Map.keys(set_1)
    keys_2 = Map.keys(set_2)

    (keys_1 ++ keys_2)
    |> Enum.uniq()
    |> new()
  end
end
