defmodule CatracaWeb.FormHelpers do
  def get_field_value(form, key, default \\ nil) do
    changes = Map.get(form.source, :changes, %{})

    value = Map.get(changes, key) || Map.get(form.data, key)

    value || default
  end

  def is_editing(form) do
    Ecto.get_meta(form.data, :state) == :loaded
  end
end
