defmodule CatracaWeb.FeaturesTest do
  use ExUnit.Case
  alias Catraca.Rule.Property

  @valid_attrs %{
    rule: %Property{
      property: "customer.email",
      condition: :contains,
      value: "@company-mail.com"
    }
  }

  test "list_features/0 returns all features" do
    feature = CatracaWeb.Seed.feature_fixture("features.test.v1", @valid_attrs)

    assert Enum.member?(CatracaWeb.Features.list_features(), feature)
  end

  test "get_feature!/1 returns feature by given key" do
    feature = CatracaWeb.Seed.feature_fixture("features.test.v2", @valid_attrs)

    assert CatracaWeb.Features.get_feature!("features.test.v2") == feature
  end

  test "update_feature!/1 updates feature" do
    feature = CatracaWeb.Seed.feature_fixture("features.test.v3", @valid_attrs)

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
