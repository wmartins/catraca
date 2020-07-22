defmodule Catraca.PropertyMapTest do
  use ExUnit.Case
  doctest Catraca.PropertyMap

  test "gets property by key from a map" do
    properties = %{
      "person" => %{
        "contact" => %{
          "email" => "some@email.com"
        }
      }
    }

    assert Catraca.PropertyMap.fetch(properties, "person.contact.email") == "some@email.com"
  end

  test "gets property by key from a map with custom separator" do
    properties = %{
      "person" => %{
        "contact" => %{
          "email" => "some@email.com"
        }
      }
    }

    assert Catraca.PropertyMap.fetch(properties, "person/contact/email", "/") == "some@email.com"
  end

  test "fails when trying to get non existent property" do
    assert Catraca.PropertyMap.fetch(%{}, "does.not.exist") == nil
  end
end
