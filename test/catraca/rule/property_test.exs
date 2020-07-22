defmodule Catraca.Rule.PropertyTest do
  use ExUnit.Case
  doctest Catraca.Rule.Property

  test "creates Property rules" do
    assert %{
             property: "email",
             condition: "contains",
             value: "@email.com"
           } = %Catraca.Rule.Property{
             property: "email",
             condition: "contains",
             value: "@email.com"
           }
  end
end
