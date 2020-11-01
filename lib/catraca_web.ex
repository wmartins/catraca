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
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/catraca_web/templates"

      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2]
      alias CatracaWeb.Router.Helpers, as: Routes
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
