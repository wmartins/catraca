defmodule CatracaWeb.FeatureController do
  use CatracaWeb, :controller

  alias Catraca.{Feature, Repo}
  alias CatracaWeb.RuleParser

  def create(conn, %{"key" => key, "rule" => rule}) do
    parsed_rule = RuleParser.parse!(rule)

    response =
      Repo.insert!(%Feature{
        key: key,
        active: true,
        rule: parsed_rule
      })

    render(conn, "create.json", %{response: response})
  end

  def update(conn, %{"key" => key, "rule" => rule}) do
    parsed_rule = RuleParser.parse!(rule)
    feature = Repo.get!(Feature, key)

    response =
      Feature.changeset(feature, %{rule: parsed_rule})
      |> Repo.update!()

    render(conn, "update.json", %{response: response})
  end

  def eval(conn, %{"feature" => feature}) do
    response = %{
      is_active:
        Feature
        |> Repo.get(feature)
        |> Feature.enabled?(conn.body_params)
    }

    render(conn, "eval.json", %{response: response})
  end
end
