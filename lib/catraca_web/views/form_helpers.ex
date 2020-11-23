defmodule CatracaWeb.FormHelpers do
  def get_field_value(form, key) do
    value = Map.get(form.source.changes, key) || Map.get(form.data, key)

    value
  end

  def is_editing(form) do
    Ecto.get_meta(form.data, :state) == :loaded
  end
end
