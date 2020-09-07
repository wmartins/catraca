defmodule CatracaAPI.Endpoint do
  use Plug.Builder

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason

  plug CatracaAPI.Router
end