defmodule CatracaWeb.HealthCheckView do
  use CatracaWeb, :view

  def render("index.json", _assigns) do
    {:ok, version} = :application.get_key(:catraca, :vsn)

    now = DateTime.utc_now() |> DateTime.to_iso8601()

    %{
      version: List.to_string(version),
      now: now
    }
  end
end
