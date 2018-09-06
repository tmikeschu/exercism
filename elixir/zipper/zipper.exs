defmodule BinTree do
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{value: any, left: BinTree.t() | nil, right: BinTree.t() | nil}
  defstruct value: nil, left: nil, right: nil
end

defmodule Zipper do
  @type t :: %Zipper{focus: BT.t(), up: Zipper.t() | nil, came_from: :left | :right}
  defstruct focus: %BinTree{}, up: nil, came_from: nil

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t()) :: Z.t()
  def from_tree(bt), do: %Zipper{focus: bt}

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t()) :: BT.t()
  def to_tree(%Zipper{up: nil, focus: focus}), do: focus
  def to_tree(%Zipper{} = z), do: to_tree(up(z))

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t()) :: any
  def value(%Zipper{focus: %BinTree{value: value}}), do: value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t()) :: Z.t() | nil
  def left(%Zipper{focus: %BinTree{left: nil}}), do: nil

  def left(%Zipper{focus: %BinTree{left: left}} = z) do
    %Zipper{focus: left, up: z, came_from: :left}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t()) :: Z.t() | nil
  def right(%Zipper{focus: %BinTree{right: nil}}), do: nil

  def right(%Zipper{focus: %BinTree{right: right}} = z) do
    %Zipper{focus: right, up: z, came_from: :right}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t()) :: Z.t()
  def up(%Zipper{up: nil}), do: nil

  def up(%Zipper{up: up, came_from: cf, focus: f}) do
    %{up | focus: %{up.focus | cf => f}}
  end

  @doc """
  Set a property value on the focus node
  """
  @spec set_focus(Z.t(), atom, any) :: Z.t()
  def set_focus(%Zipper{focus: f} = z, prop, value) do
    %{z | focus: %{f | prop => value}}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t(), any) :: Z.t()
  def set_value(z, v), do: set_focus(z, :value, v)

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t(), BT.t()) :: Z.t()
  def set_left(z, l), do: set_focus(z, :left, l)

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t(), BT.t()) :: Z.t()
  def set_right(z, r), do: set_focus(z, :right, r)
end
