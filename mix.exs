defmodule Catraca.MixProject do
  use Mix.Project

  def project do
    [
      app: :catraca,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Catraca.Application, []}
    ]
  end

  defp deps do
    [
      {:etso, "~> 0.1.1"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.3"}
    ]
  end
end
