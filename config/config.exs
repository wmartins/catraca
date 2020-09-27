use Mix.Config

config :catraca, ecto_repos: [Catraca.Repo]

config :catraca, CatracaAPI.Endpoint,
  server: true,
  http: [port: 4001],
  render_errors: [
    view: CatracaAPI.ErrorView,
    accepts: ~w(html),
    layout: false,
    log: :debug
  ]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
