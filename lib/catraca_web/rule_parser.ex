defmodule CatracaWeb.RuleParser.ParseError do
  defexception [:message, :rule]
end

defmodule CatracaWeb.RuleParser do
  @moduledoc """
  This module is responsible to parse a JSON like structure (probably
  received via HTTP) and create rules based on them.
  """

  @doc """
  The `parse!` method receives a map and returns a `Catraca.Rule`.

  It'll raise in case of any errors.
  """
  @spec parse!(map()) :: Catraca.Rule.And.t() | Catraca.Rule.Or.t() | Catraca.Rule.Property.t()
  def parse!(%{"and" => rules}) do
    %Catraca.Rule.And{
      rules: Enum.map(rules, &parse!(&1))
    }
  end

  def parse!(%{"or" => rules}) do
    %Catraca.Rule.Or{
      rules: Enum.map(rules, &parse!(&1))
    }
  end

  def parse!(%{"property" => property, "condition" => condition, "value" => value}) do
    %Catraca.Rule.Property{
      property: property,
      condition: String.to_existing_atom(condition),
      value: value
    }
  end

  def parse!(rule) do
    raise CatracaWeb.RuleParser.ParseError, message: "Unable to parse", rule: rule
  end
end
