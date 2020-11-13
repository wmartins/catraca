use Mix.Config

config :catraca, ecto_repos: [Catraca.Repo]

config :catraca, CatracaWeb.Endpoint,
  server: true,
  http: [port: 4001],
  secret_key_base: "g0I3qnfQKeLs7hKO2KBTBV3WR7HoPS5+P0IaGIS3nzJ2RsO7ZSlf48Qj0YHNMZeF",
  render_errors: [
    view: CatracaWeb.ErrorView,
    accepts: ~w(html),
    layout: false,
    log: :debug
  ],
  pubsub_server: Catraca.PubSub

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
