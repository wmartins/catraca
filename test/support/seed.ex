defmodule CatracaWeb.Seed do
  def feature_fixture(key, feature) do
    CatracaWeb.Features.create_feature(key, feature)
  end
end
