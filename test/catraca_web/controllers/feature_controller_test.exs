defmodule CatracaWeb.FeatureControllerTest do
  use CatracaWeb.ConnCase
  import CatracaWeb.Seed
  import Phoenix.HTML
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
    key = gen_feature_key()
    CatracaWeb.Features.create_feature(key, @valid_attrs)

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
    key = gen_feature_key()

    conn =
      post(conn, "/v1/feature", %{
        key: key,
        rule: %{
          property: "customer.email",
          condition: "contains",
          value: "@company-mail.com"
        }
      })

    body = json_response(conn, 200)

    assert body["key"] == key
  end

  test "POST /create", %{conn: conn} do
    key = gen_feature_key()

    conn =
      post(conn, Routes.feature_path(conn, :create), %{
        feature: %{
          key: key,
          rule: %{
            property: "customer.email",
            condition: "contains",
            value: "@company-mail.com"
          }
        }
      })

    assert redirected_to(conn) == Routes.feature_path(conn, :index)
  end

  test "PUT /update/:key", %{conn: conn} do
    key = gen_feature_key()

    CatracaWeb.Features.create_feature(key, @valid_attrs)

    conn =
      put(conn, "/update/#{key}", %{
        key: key,
        feature: %{
          rule: %{
            property: "updated.property",
            condition: "gt",
            value: 30
          }
        }
      })

    assert redirected_to(conn) == Routes.feature_path(conn, :index)

    feature = CatracaWeb.Features.get_feature!(key)

    assert feature.rule == %Catraca.Rule.Property{
             property: "updated.property",
             condition: :gt,
             value: 30
           }
  end

  test "PUT /v1/feature/:key", %{conn: conn} do
    key = gen_feature_key()

    CatracaWeb.Features.create_feature(key, @valid_attrs)

    conn =
      put(conn, "/v1/feature/#{key}", %{
        key: key,
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

  test "GET /", %{conn: conn} do
    key = gen_feature_key()

    CatracaWeb.Features.create_feature(key, @valid_attrs)

    conn = get(conn, "/")

    assert html_response(conn, 200) =~ key
  end

  test "GET /edit/:key", %{conn: conn} do
    key = gen_feature_key()

    CatracaWeb.Features.create_feature(key, @valid_attrs)

    conn = get(conn, "/edit/#{key}")

    assert html_response(conn, 200) =~ key
  end

  test "GET /eval/:key", %{conn: conn} do
    key = gen_feature_key()

    CatracaWeb.Features.create_feature(key, @valid_attrs)

    conn = get(conn, "/eval/#{key}")

    assert html_response(conn, 200) =~ key
  end

  test "POST /eva/:key", %{conn: conn} do
    key = gen_feature_key()

    CatracaWeb.Features.create_feature(key, @valid_attrs)

    conn =
      post(conn, "/eval/#{key}", %{
        payload:
          Jason.encode!(%{
            email: "user@company-mail.com"
          })
      })

    assert html_response(conn, 200) =~ "Evaluation result:"
    assert html_response(conn, 200) =~ ~s({ "is_active": true }) |> safe_to_string |> html_escape
  end
end
