defmodule Catraca.Rule.And do
  @derive {Jason.Encoder, only: [:rules]}
  @moduledoc """
  Stores `And` rules. Those rules, when evaluated, will return the value of
  applying Kernel.and for all the rules.

  In other words:

  - %Catraca.Rule.And{rules: [true, true, true]} will evaluate to `true`.
  - %Catraca.Rule.And{rules: [true, false]} will evaluate to `false`.
  - %Catraca.Rule.And{rules: [false, false]} will evaluate to `false`.

  ## Rules

  An array containing all rules.

  ## Examples

      iex> %Catraca.Rule.Or{rules: []}
      %Catraca.Rule.Or{rules: []}
  """
  defstruct [:rules]
end
