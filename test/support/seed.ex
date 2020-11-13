defmodule CatracaWeb.Seed do
  # https://dreamconception.com/tech/elixir-simple-way-to-create-random-reference-ids/
  def gen_feature_key() do
    min = String.to_integer("100000", 36)
    max = String.to_integer("ZZZZZZ", 36)

    max
    |> Kernel.-(min)
    |> :rand.uniform()
    |> Kernel.+(min)
    |> Integer.to_string(36)
  end

  def feature_fixture(key, feature) do
    CatracaWeb.Features.create_feature(key, feature)
  end
end
