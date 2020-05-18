defmodule Zipper do
  @doc """
  Get a zipper focused on the root node.
  """
  alias BinTree

  @type t :: %Zipper{node: BinTree.t(), trail: list()}
  defstruct [:node, :trail]

  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree), do: %Zipper{node: bin_tree, trail: [{:top, bin_tree}]}

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%Zipper{trail: [{:top, bin_tree}]}), do: bin_tree
  def to_tree(%Zipper{trail: [head | tail]}), do: set_trail(head, tail)

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(%Zipper{node: %BinTree{value: value}}), do: value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%Zipper{node: %BinTree{left: nil}}), do: nil

  def left(%Zipper{node: %BinTree{left: left_node}, trail: trail}),
    do: %Zipper{node: left_node, trail: [{:left, left_node} | trail]}

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%Zipper{node: %BinTree{right: nil}}), do: nil

  def right(%Zipper{node: %BinTree{right: right_node}, trail: trail}),
    do: %Zipper{node: right_node, trail: [{:right, right_node} | trail]}

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%Zipper{trail: [{:top, _}]}), do: nil

  def up(%Zipper{trail: [_ | trail]}) do
    {_, bin_tree} = Enum.at(trail, 0)
    %Zipper{node: bin_tree, trail: trail}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(%Zipper{node: node, trail: [{direction, _} | trail]}, value) do
    new_node = %BinTree{node | value: value}
    %Zipper{node: new_node, trail: [{direction, new_node} | trail]}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(%Zipper{node: node, trail: [{direction, _} | trail]}, left) do
    new_node = %BinTree{node | left: left}
    %Zipper{node: new_node, trail: [{direction, new_node} | trail]}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(%Zipper{node: node, trail: [{direction, _} | trail]}, right) do
    new_node = %BinTree{node | right: right}
    %Zipper{node: new_node, trail: [{direction, new_node} | trail]}
  end

  defp set_trail({:left, child}, [{_, parent} | _] = trail),
    do: set_trail(trail, %BinTree{parent | left: child})

  defp set_trail({:right, child}, [{_, parent} | _] = trail),
    do: set_trail(trail, %BinTree{parent | right: child})

  defp set_trail([{:left, _} | [{_, parent} | _] = trail], child),
    do: set_trail(trail, %BinTree{parent | left: child})

  defp set_trail([{:right, _} | [{_, parent} | _] = trail], child),
    do: set_trail(trail, %BinTree{parent | right: child})

  defp set_trail([{:top, _}], child), do: child
end
