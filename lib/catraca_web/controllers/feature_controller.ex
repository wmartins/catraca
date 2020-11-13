defmodule CatracaWeb.FeatureController do
  use CatracaWeb, :controller

  alias Catraca.{Feature}
  alias CatracaWeb.{Features, RuleParser}

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    changeset =
      %Feature{
        key: "key.example",
        rule: %Catraca.Rule.Property{
          property: "email",
          condition: :contains,
          value: "@company-mail.com"
        }
      }
      |> Feature.changeset()

    render(conn, "new.html", %{changeset: changeset})
  end

  def create(conn, %{"feature" => %{"key" => key, "rule" => rule}}) do
    parsed_rule = RuleParser.parse!(rule)

    case Features.create_feature(key, %{key: key, rule: parsed_rule}) do
      {:ok, feature} ->
        conn
        |> put_flash(:info, "Feature #{feature.key} created")
        |> redirect(to: Routes.feature_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(
          :error,
          "An error occured while creating the feature, review the fields and try again"
        )
        |> render("new.html", %{changeset: changeset})
    end
  end

  def create(conn, %{"key" => key, "rule" => rule}) do
    parsed_rule = RuleParser.parse!(rule)

    case Features.create_feature(key, %{rule: parsed_rule}) do
      {:ok, response} -> render(conn, "create.json", %{response: response})
      {:error, changeset} -> render(conn, "error.json", %{changeset: changeset})
    end
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
