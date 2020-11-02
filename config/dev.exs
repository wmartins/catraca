use Mix.Config

config :catraca, CatracaWeb.Endpoint,
  debug_errors: true,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ],
  code_reloader: true,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"lib/catraca_web/(live|views)/.*(ex)$",
      ~r"lib/catraca_web/templates/.*(eex)$"
    ]
  ]
