defmodule Catraca.Rule do
  def evaluate(
        %Catraca.Rule.Property{
          property: property,
          condition: condition,
          value: value
        },
        properties
      ) do
    Catraca.Comparison.compare(
      Catraca.PropertyMap.fetch(properties, property),
      condition,
      value
    )
  end

  def evaluate(%Catraca.Rule.And{rules: rules}, properties) do
    Enum.map(rules, &Catraca.Rule.evaluate(&1, properties))
    |> Enum.reduce(&Kernel.and(&1, &2))
  end

  def evaluate(%Catraca.Rule.Or{rules: rules}, properties) do
    Enum.map(rules, &Catraca.Rule.evaluate(&1, properties))
    |> Enum.reduce(&Kernel.or(&1, &2))
  end
end
