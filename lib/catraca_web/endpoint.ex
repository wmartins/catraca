defmodule CatracaWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :catraca

  @session_options [
    store: :cookie,
    key: "_catraca_web_key",
    signing_salt: "AbXvkPod8ScBw73CigWN2pGSqjx5mXbqSK2WAt39k4qsuXPfUw3Kj72lbUOccLmR"
  ]

  plug(Plug.Static,
    at: "/",
    from: :catraca,
    gzip: false,
    only: ~w(css js images robots.txt)
  )

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug(Plug.Logger)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(Plug.Session, @session_options)

  plug(CatracaWeb.Router)
end
