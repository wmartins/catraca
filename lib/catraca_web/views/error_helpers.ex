defmodule CatracaWeb.ErrorHelpers do
  use Phoenix.HTML

  def error_tag(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn {error, _} ->
      content_tag(:span, error, data: [phx_error_for: input_id(form, field)])
    end)
  end
end
