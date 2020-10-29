defmodule CatracaWeb.FeatureControllerTest do
  use CatracaWeb.ConnCase
  alias Catraca.Rule.{And, Or, Property}

  @valid_attrs %{
    rule: %And{
      rules: [
        %Property{
          property: "customer.email",
          condition: :contains,
          value: "@company-mail.com"
        },
        %Or{
          rules: [
            %Property{
              property: "customer.group",
              condition: :in,
              value: ["beta", "alpha"]
            },
            %Property{
              property: "customer.days_using_app",
              condition: :gt,
              value: 10
            }
          ]
        }
      ]
    }
  }

  test "POST /eval", %{conn: conn} do
    CatracaWeb.Features.create_feature("feature.v1", @valid_attrs)
    key = "feature.v1"

    conn =
      post(conn, "/v1/feature/#{key}/eval", %{
        customer: %{
          email: "person@company-mail.com",
          group: "beta",
          days_using_app: "15"
        }
      })

    body = json_response(conn, 200)

    assert body["is_active"] == true
  end

  test "POST /", %{conn: conn} do
    conn =
      post(conn, "/v1/feature", %{
        key: "feature.v2",
        rule: %{
          property: "customer.email",
          condition: "contains",
          value: "@company-mail.com"
        }
      })

    body = json_response(conn, 200)

    assert body["key"] == "feature.v2"
  end

  test "PUT /", %{conn: conn} do
    CatracaWeb.Features.create_feature("feature.v3", @valid_attrs)

    conn =
      put(conn, "/v1/feature", %{
        key: "feature.v3",
        rule: %{
          property: "updated.property",
          condition: "gt",
          value: 30
        }
      })

    body = json_response(conn, 200)

    assert body["rule"] == %{
             "property" => "updated.property",
             "condition" => "gt",
             "value" => 30
           }
  end
end
