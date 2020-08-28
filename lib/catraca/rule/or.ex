defmodule Catraca.Rule.Or do
  @derive {Jason.Encoder, only: [:rules]}
  @moduledoc """
  Stores `Or` rules. Those rules, when evaluated, will return the value of
  applying Kernel.or for all the rules.

  In other words:

  - %Catraca.Rule.Or{rules: [true, true, true]} will evaluate to `true`.
  - %Catraca.Rule.Or{rules: [true, false]} will evaluate to `true`.
  - %Catraca.Rule.Or{rules: [false, false]} will evaluate to `false`.

  ## Rules

  An array containing all rules.

  ## Examples

      iex> %Catraca.Rule.Or{rules: []}
      %Catraca.Rule.Or{rules: []}
  """
  defstruct [:rules]
end
