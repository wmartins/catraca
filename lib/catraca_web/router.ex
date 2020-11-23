defimpl Plug.Exception, for: Ecto.InvalidChangesetError do
  def actions(_), do: []
  def status(_), do: 409
end

defimpl Plug.Exception, for: CatracaWeb.RuleParser.ParseError do
  def actions(_), do: []
  def status(_), do: 422
end

defmodule CatracaWeb.Router do
  @on_load :ensure_comparison_atoms_loaded
  use CatracaWeb, :router

  def ensure_comparison_atoms_loaded do
    # https://github.com/elixir-lang/elixir/issues/4832#issuecomment-227099444
    Code.ensure_loaded?(Catraca.Comparison)
    :ok
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  get("/status", CatracaWeb.HealthCheckController, :status)

  scope "/", CatracaWeb do
    pipe_through(:browser)
    get("/", FeatureController, :index)

    get("/new", FeatureController, :new)
    post("/create", FeatureController, :create)

    get("/edit/:key", FeatureController, :edit)
    put("/update/:key", FeatureController, :update)
  end

  scope "/v1/feature", CatracaWeb do
    post("/", FeatureController, :create)
    put("/:key", FeatureController, :update)
    post("/:feature/eval", FeatureController, :eval)
  end
end
