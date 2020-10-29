defimpl Plug.Exception, for: Ecto.NoResultsError do
  def actions(_), do: []
  def status(_), do: 404
end

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

  get("/status", CatracaWeb.HealthCheckController, :status)

  scope "/v1/feature", CatracaWeb do
    post("/", FeatureController, :create)
    put("/", FeatureController, :update)
    post("/:feature/eval", FeatureController, :eval)
  end
end
