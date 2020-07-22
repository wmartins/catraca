defmodule Catraca.Rule.AndTest do
  use ExUnit.Case
  doctest Catraca.Rule.And

  test "creates And rules" do
    assert %{rules: []} = %Catraca.Rule.And{rules: []}
  end
end
