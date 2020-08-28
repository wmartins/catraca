defmodule Catraca.Rule.Property do
  @derive {Jason.Encoder, only: [:property, :condition, :value]}
  @moduledoc """
  Stores property based rules. Those rules are used to match a value from a
  property against a specific value or set of values.

  ## Property

  The name of property, it can be anything you want, however, it'll be best
  used if you can prefix your properties, in case of nested ones.

  Some examples of properties:

  - "person.name"
  - "person.email"
  - "person/name"
  - "person/email"

  ## Condition

  An atom (preferably) to represent a comparison operation.

  Some examples:

  - :eq - to check for equalities
  - :in - to check if a value is in a set of values
  - :contains - to check if a value contains another

  ## Value

  The value itself.

  ## Examples

      iex> %Catraca.Rule.Property{
      ...>   property: "person.email",
      ...>   condition: :contains,
      ...>   value: "@email.com"
      ...> }
      %Catraca.Rule.Property{
        property: "person.email",
        condition: :contains,
        value: "@email.com"
      }
  """
  defstruct [:property, :condition, :value]
end
