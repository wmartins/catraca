defmodule CatracaAPI.RuleParserTest do
  use ExUnit.Case
  doctest CatracaAPI.RuleParser

  test "parses property rules" do
    rule = %{
      "property" => "person.email",
      "condition" => "contains",
      "value" => "@email.com"
    }

    parsed = CatracaAPI.RuleParser.parse!(rule)

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

    parsed = CatracaAPI.RuleParser.parse!(rule)

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

    parsed = CatracaAPI.RuleParser.parse!(rule)

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

    parsed = CatracaAPI.RuleParser.parse!(rule)

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

  test "throws error when parsing wrong rules" do
    assert_raise CatracaAPI.RuleParser.ParseError, fn ->
      CatracaAPI.RuleParser.parse!(%{"other" => []})
    end
  end
end
