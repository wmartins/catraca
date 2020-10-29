defmodule CatracaWeb.HealthCheckController do
  use CatracaWeb, :controller

  def status(conn, _params) do
    render(conn, "index.json")
  end
end
