defimpl Plug.Exception, for: Ecto.NoResultsError do
  def actions(_), do: []
  def status(_), do: 404
end

defimpl Plug.Exception, for: Ecto.InvalidChangesetError do
  def actions(_), do: []
  def status(_), do: 409
end

defimpl Plug.Exception, for: CatracaAPI.RuleParser.ParseError do
  def actions(_), do: []
  def status(_), do: 422
end

defmodule CatracaAPI.Router do
  @on_load :ensure_comparison_atoms_loaded
  use Plug.Router
  use Plug.ErrorHandler

  alias Catraca.{Feature, Repo}
  alias CatracaAPI.RuleParser

  def ensure_comparison_atoms_loaded do
    # https://github.com/elixir-lang/elixir/issues/4832#issuecomment-227099444
    Code.ensure_loaded?(Catraca.Comparison)
    :ok
  end

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  post "/v1/feature" do
    %{"key" => key, "rule" => rule} = conn.body_params
    parsed_rule = RuleParser.parse!(rule)

    response =
      Repo.insert!(%Feature{
        key: key,
        active: true,
        rule: parsed_rule
      })

    send_resp(conn, 200, Jason.encode!(response))
  end

  put "/v1/feature" do
    %{"key" => key, "rule" => rule} = conn.body_params
    parsed_rule = RuleParser.parse!(rule)
    feature = Repo.get!(Feature, key)

    response =
      Feature.changeset(feature, %{rule: parsed_rule})
      |> Repo.update!()

    send_resp(conn, 200, Jason.encode!(response))
  end

  post "/v1/feature/:feature/eval" do
    response = %{
      is_active:
        Feature
        |> Repo.get(feature)
        |> Feature.enabled?(conn.body_params)
    }

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(response))
  end

  get "/status" do
    {:ok, version} = :application.get_key(:catraca, :vsn)

    now = DateTime.utc_now() |> DateTime.to_iso8601()

    response = %{
      version: List.to_string(version),
      now: now
    }

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(response))
  end
end
