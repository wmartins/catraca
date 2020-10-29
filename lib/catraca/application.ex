defmodule Catraca.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_, _) do
    children = [
      Catraca.Repo,
      CatracaWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Catraca.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
