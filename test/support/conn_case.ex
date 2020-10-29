defmodule CatracaWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      alias CatracaWeb.Router.Helper, as: Routes

      @endpoint CatracaWeb.Endpoint
    end
  end

  setup _tags do
    %{conn: Phoenix.ConnTest.build_conn()}
  end
end
