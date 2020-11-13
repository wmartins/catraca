defmodule Catraca.Feature do
  use Ecto.Schema
  import Ecto.Changeset
  alias Catraca.{Rule, Feature}

  @derive {Phoenix.Param, key: :key}
  @derive {Jason.Encoder, only: [:key, :rule]}

  # Sadly, Etso has a problem when integrating with Ecto to display unique errors
  # https://github.com/evadne/etso/issues/7
  @primary_key {:key, :string, autogenerate: false}
  @enforce_keys [:key, :rule]
  schema "feature" do
    field(:rule, :map)
    field(:active, :boolean)
  end

  def changeset(feature, params \\ %{}) do
    feature
    |> cast(params, [:rule])
    |> validate_required([:rule])
    |> unique_constraint(:key, name: :primary_key)
  end

  def enabled?(%Feature{:rule => rule}, payload) do
    Rule.evaluate(rule, payload)
  end
end
