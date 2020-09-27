defmodule CatracaAPI.HealthCheckController do
  use CatracaAPI, :controller

  def status(conn, _params) do
    render(conn, "index.json")
  end
end
