defmodule Catraca.RuleTest do
  use ExUnit.Case
  doctest Catraca.Rule

  @rules %Catraca.Rule.Or{
    rules: [
      %Catraca.Rule.Property{
        property: "group",
        condition: :in,
        value: ["beta", "alpha"]
      },
      %Catraca.Rule.And{
        rules: [
          %Catraca.Rule.Property{
            property: "customer.email",
            condition: :contains,
            value: "@email.com"
          },
          %Catraca.Rule.Property{
            property: "customer.age",
            condition: :gt,
            value: 25
          }
        ]
      }
    ]
  }

  test "evaluates to true when matches all `and` rules" do
    properties = %{
      "customer" => %{
        "email" => "@email.com",
        "age" => 30
      }
    }

    assert Catraca.Rule.evaluate(@rules, properties)
  end

  test "evaluates to true when matches one `or` rules" do
    properties = %{
      "group" => "beta"
    }

    assert Catraca.Rule.evaluate(@rules, properties)
  end

  test "evaluates to false when rules don't match" do
    properties = %{
      "customer" => %{
        "email" => "@email.com",
        "age" => 20
      }
    }

    refute Catraca.Rule.evaluate(@rules, properties)
  end
end
