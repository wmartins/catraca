defmodule Catraca.Rule.OrTest do
  use ExUnit.Case
  doctest Catraca.Rule.Or

  test "creates Or rules" do
    assert %{rules: []} = %Catraca.Rule.Or{rules: []}
  end
end
