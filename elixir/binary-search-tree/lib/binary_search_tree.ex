defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data), do: %{data: data, left: nil, right: nil}

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: root, left: nil} = tree, data) when data <= root,
    do: %{tree | left: new(data)}

  def insert(%{right: nil} = tree, data),
    do: %{tree | right: new(data)}

  def insert(%{data: root} = tree, data) when data <= root,
    do: %{tree | left: insert(tree.left, data)}

  def insert(tree, data),
    do: %{tree | right: insert(tree.right, data)}

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(%{data: data, left: nil, right: nil}), do: [data]

  def in_order(%{data: data, left: left, right: nil}), do: in_order(left) ++ [data]

  def in_order(%{data: data, left: nil, right: right}), do: [data] ++ in_order(right)

  def in_order(%{data: data, left: left, right: right}),
    do: in_order(left) ++ [data] ++ in_order(right)
end
