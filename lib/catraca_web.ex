defmodule CatracaWeb do
  def router do
    quote do
      use Phoenix.Router
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      import Plug.Conn

      alias CatracaWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/catraca_web/templates"

      import Phoenix.Controller, only: [put_flash: 3, get_flash: 1, get_flash: 2]
      import Phoenix.HTML.Form
      import CatracaWeb.FormHelpers
      import CatracaWeb.ErrorHelpers

      alias CatracaWeb.Router.Helpers, as: Routes
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
