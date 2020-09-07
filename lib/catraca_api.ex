defmodule CatracaAPI do
  def router do
    quote do
      use Plug.Router
      use Plug.ErrorHandler
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
