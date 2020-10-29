defmodule CatracaWeb.FeatureController do
  use CatracaWeb, :controller

  alias Catraca.{Feature}
  alias CatracaWeb.{Features, RuleParser}

  def create(conn, %{"key" => key, "rule" => rule}) do
    parsed_rule = RuleParser.parse!(rule)

    response = Features.create_feature(key, %{rule: parsed_rule})

    render(conn, "create.json", %{response: response})
  end

  def update(conn, %{"key" => key, "rule" => rule}) do
    parsed_rule = RuleParser.parse!(rule)

    feature = Features.get_feature!(key)

    response = Features.update_feature!(feature, %{rule: parsed_rule})

    render(conn, "update.json", %{response: response})
  end

  def eval(conn, %{"feature" => feature}) do
    response = %{
      is_active:
        Features.get_feature!(feature)
        |> Feature.enabled?(conn.body_params)
    }

    render(conn, "eval.json", %{response: response})
  end
end
