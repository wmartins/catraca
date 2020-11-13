defmodule CatracaWeb.RuleParserTest do
  use ExUnit.Case
  doctest CatracaWeb.RuleParser

  test "parses property rules" do
    rule = %{
      "property" => "person.email",
      "condition" => "contains",
      "value" => "@email.com"
    }

    parsed = CatracaWeb.RuleParser.parse!(rule)

    expected = %Catraca.Rule.Property{
      property: "person.email",
      condition: :contains,
      value: "@email.com"
    }

    assert parsed == expected
  end

  test "parses and rules" do
    rule = %{
      "and" => [
        %{
          "property" => "person.email",
          "condition" => "contains",
          "value" => "@email.com"
        }
      ]
    }

    parsed = CatracaWeb.RuleParser.parse!(rule)

    expected = %Catraca.Rule.And{
      rules: [
        %Catraca.Rule.Property{
          property: "person.email",
          condition: :contains,
          value: "@email.com"
        }
      ]
    }

    assert parsed == expected
  end

  test "parses or rules" do
    rule = %{
      "or" => [
        %{
          "property" => "person.email",
          "condition" => "contains",
          "value" => "@email.com"
        }
      ]
    }

    parsed = CatracaWeb.RuleParser.parse!(rule)

    expected = %Catraca.Rule.Or{
      rules: [
        %Catraca.Rule.Property{
          property: "person.email",
          condition: :contains,
          value: "@email.com"
        }
      ]
    }

    assert parsed == expected
  end

  test "parses nested rules" do
    rule = %{
      "or" => [
        %{
          "and" => [
            %{
              "property" => "person.email",
              "condition" => "contains",
              "value" => "@email.com"
            },
            %{
              "property" => "person.groups",
              "condition" => "includes",
              "value" => "beta"
            }
          ]
        },
        %{
          "property" => "person.age",
          "condition" => "gt",
          "value" => 30
        }
      ]
    }

    parsed = CatracaWeb.RuleParser.parse!(rule)

    expected = %Catraca.Rule.Or{
      rules: [
        %Catraca.Rule.And{
          rules: [
            %Catraca.Rule.Property{
              property: "person.email",
              condition: :contains,
              value: "@email.com"
            },
            %Catraca.Rule.Property{
              property: "person.groups",
              condition: :includes,
              value: "beta"
            }
          ]
        },
        %Catraca.Rule.Property{
          property: "person.age",
          condition: :gt,
          value: 30
        }
      ]
    }

    assert parsed == expected
  end

  test "parses string values" do
    parsed = CatracaWeb.RuleParser.parse!(~s(
      {
        "and": [
          {
            "property": "email",
            "condition": "contains",
            "value": "@company-mail.com"
          },
          {
            "property": "group",
            "condition": "in",
            "value": ["employees", "beta"]
          }
        ]
      }
    ))

    expected = %Catraca.Rule.And{
      rules: [
        %Catraca.Rule.Property{
          property: "email",
          condition: :contains,
          value: "@company-mail.com"
        },
        %Catraca.Rule.Property{
          property: "group",
          condition: :in,
          value: ["employees", "beta"]
        }
      ]
    }

    assert parsed == expected
  end

  test "throws error when parsing wrong rules" do
    assert_raise CatracaWeb.RuleParser.ParseError, fn ->
      CatracaWeb.RuleParser.parse!(%{"other" => []})
    end
  end
end
