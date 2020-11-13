defmodule CatracaWeb.FeaturesTest do
  use ExUnit.Case
  import CatracaWeb.Seed
  alias Catraca.Rule.Property

  @valid_attrs %{
    rule: %Property{
      property: "customer.email",
      condition: :contains,
      value: "@company-mail.com"
    }
  }

  test "list_features/0 returns all features" do
    {:ok, feature} = feature_fixture(gen_feature_key(), @valid_attrs)

    assert Enum.member?(CatracaWeb.Features.list_features(), feature)
  end

  test "get_feature!/1 returns feature by given key" do
    key = gen_feature_key()
    {:ok, feature} = feature_fixture(key, @valid_attrs)

    assert CatracaWeb.Features.get_feature!(key) == feature
  end

  test "update_feature!/1 updates feature" do
    {:ok, feature} = feature_fixture(gen_feature_key(), @valid_attrs)

    updated =
      CatracaWeb.Features.update_feature!(feature, %{
        rule: %Property{
          property: "customer.alternate_email",
          condition: :contains,
          value: "@company-alternate-email.com"
        }
      })

    assert updated.rule.property == "customer.alternate_email"
  end
end
