defmodule CatracaAPI do
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
        root: "lib/catraca_api/templates"
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
