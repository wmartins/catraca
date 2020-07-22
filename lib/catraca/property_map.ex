defmodule Catraca.PropertyMap do
  @moduledoc """
  This module is a collection of methods to interact with properties in a
  map.

  Check `Catraca.PropertyMap.fetch/3` for more.
  """

  @doc """
  Fetches a specified `property` in `properties` map. The `separator` can
  also be customized.

  ## Options:

  - `properties`: map containing all properties
  - `property`: a string path to get property (for example "my.custom.property")
  - `separator`: the separator used in `property`

  ## Examples:

      iex> Catraca.PropertyMap.fetch(%{"a" => %{"b" => 10}}, "a.b")
      10

      iex> Catraca.PropertyMap.fetch(%{"a" => %{"b" => 50}}, "a/b", "/")
      50
  """
  @spec fetch(map, String.t(), String.t()) :: any() | nil
  def fetch(properties, property, separator \\ ".") do
    try do
      String.split(property, separator)
      |> Enum.reduce(properties, &Map.get(&2, &1))
    rescue
      BadMapError -> nil
    end
  end
end
