defmodule CatracaAPI.FeatureView do
  use CatracaAPI, :view

  def render("create.json", %{response: response}), do: response
  def render("update.json", %{response: response}), do: response
  def render("eval.json", %{response: response}), do: response
end
