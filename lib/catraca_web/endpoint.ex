defmodule CatracaWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :catraca

  plug(Plug.Logger)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(CatracaWeb.Router)
end
