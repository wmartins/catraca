defmodule Catraca.Comparison do
  @moduledoc """
  This module is responsible for performing comparisons between two elements.

  Check `Catraca.Comparison.compare/3` to see more on how comparisons are
  made.
  """

  @doc """
  Compares two values, based on one of the following comparison atoms:

  - :eq - checks for equality (==)
  - :gt - checks for greater than (>)
  - :lt - checks for less than (<)
  - :contains - checks if a String contains another (String.contains?/2)
  - :in - checks if an enumerable includes an element (MapSet.member?/2)

  ## Examples

      iex> Catraca.Comparison.compare(1, :eq, 1)
      true

      iex> Catraca.Comparison.compare("a", :eq, "a")
      true
  """
  def compare(left, :eq, right) do
    left == right
  end

  def compare(nil, :gt, _right), do: false
  def compare(_left, :gt, nil), do: false

  def compare(left, :gt, right) do
    left > right
  end

  def compare(nil, :lt, _right), do: false
  def compare(_left, :lt, nil), do: false

  def compare(left, :lt, right) do
    left < right
  end

  def compare(nil, :contains, _) do
    false
  end

  def compare(left, :contains, right) do
    String.contains?(left, right)
  end

  def compare(left, :in, right) do
    List.wrap(right)
    |> MapSet.new
    |> MapSet.member?(left)
  end
end
