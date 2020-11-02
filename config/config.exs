use Mix.Config

config :catraca, ecto_repos: [Catraca.Repo]

config :catraca, CatracaWeb.Endpoint,
  server: true,
  http: [port: 4001],
  render_errors: [
    view: CatracaWeb.ErrorView,
    accepts: ~w(html),
    layout: false,
    log: :debug
  ],
  pubsub_server: Catraca.PubSub

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
