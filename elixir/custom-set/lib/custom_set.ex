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
    map_set1 = Map.keys(set_1) |> MapSet.new()
    map_set2 = Map.keys(set_2) |> MapSet.new()

    MapSet.subset?(map_set1, map_set2)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(%CustomSet{map: set_1}, %CustomSet{map: set_2}) do
    {map_set1, map_set2} = sets_from_maps(set_1, set_2)

    MapSet.disjoint?(map_set1, map_set2)
  end

  @spec equal?(t, t) :: boolean
  def equal?(%CustomSet{map: set_1}, %CustomSet{map: set_2}) do
    {map_set1, map_set2} = sets_from_maps(set_1, set_2)

    MapSet.equal?(map_set1, map_set2)
  end

  @spec add(t, any) :: t
  def add(%CustomSet{map: set}, element) do
    updated_set = Map.put_new(set, element, :ok)

    %CustomSet{map: updated_set}
  end

  @spec intersection(t, t) :: t
  def intersection(%CustomSet{map: set_1}, %CustomSet{map: set_2}) do
    {map_set1, map_set2} = sets_from_maps(set_1, set_2)

    map_set1
    |> MapSet.intersection(map_set2)
    |> MapSet.to_list()
    |> CustomSet.new()
  end

  @spec difference(t, t) :: t
  def difference(%CustomSet{map: set_1}, %CustomSet{map: set_2}) do
    {map_set1, map_set2} = sets_from_maps(set_1, set_2)

    map_set1
    |> MapSet.difference(map_set2)
    |> MapSet.to_list()
    |> CustomSet.new()
  end

  @spec union(t, t) :: t
  def union(%CustomSet{map: set_1}, %CustomSet{map: set_2}) do
    {map_set1, map_set2} = sets_from_maps(set_1, set_2)

    map_set1
    |> MapSet.union(map_set2)
    |> MapSet.to_list()
    |> CustomSet.new()
  end

  defp sets_from_maps(custom_set_1, custom_set_2) do
    map_set1 =
      custom_set_1
      |> Map.keys()
      |> MapSet.new()

    map_set2 =
      custom_set_2
      |> Map.keys()
      |> MapSet.new()

    {map_set1, map_set2}
  end
end
