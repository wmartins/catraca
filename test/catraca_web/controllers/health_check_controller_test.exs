defmodule CatracaWeb.HealthCheckControllerTest do
  use CatracaWeb.ConnCase

  test "GET /status", %{conn: conn} do
    conn = get(conn, "/status")
    body = json_response(conn, 200)

    {:ok, timestamp, _} = DateTime.from_iso8601(body["now"])

    assert body["version"] != ""
    assert Enum.member?([:lt, :eq], DateTime.compare(timestamp, DateTime.utc_now()))
  end
end
