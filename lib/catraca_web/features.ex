defmodule CatracaWeb.Features do
  def get_feature!(key) do
    Catraca.Repo.get!(Catraca.Feature, key)
  end

  def list_features() do
    Catraca.Repo.all(Catraca.Feature)
  end

  def create_feature(key, attrs \\ %{}) do
    %Catraca.Feature{
      key: key,
      active: true,
      rule: []
    }
    |> Catraca.Feature.changeset(attrs)
    |> Catraca.Repo.insert!()
  end

  def update_feature!(%Catraca.Feature{} = feature, attrs) do
    feature
    |> Catraca.Feature.changeset(attrs)
    |> Catraca.Repo.update!()
  end
end
