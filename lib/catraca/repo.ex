defmodule Catraca.Repo do
  use Ecto.Repo,
    otp_app: :catraca,
    adapter: Etso.Adapter
end
