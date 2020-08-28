# Catraca

Catraca is a simple software piece that can manage feature flags resolution.

If you want to know more about feature flags, please refer to
https://www.martinfowler.com/articles/feature-toggles.html.

The way this project solves the feature flag problem is a kind of simple one,
and, whilst it could be used in production, I think it needs a little bit
more thought before that.

# Concepts

## Rule

The basic concept of this project is the concept of a `Rule`. The most basic
construct of a rule is a property based rule. Right now, there are just a few
comparisons available:

* `eq` - checks for equality
* `gt` - checks for greater than
* `lt` - checks for less than
* `contains` - checks if a String contains another one
* `in` - checks if an enumerable includes a value

## Rule Composition

Right now, it's possible to compose rules using `and` and `or` rules. In
other words, if you want to check for both two properties, you should compose
them with an `and` rule, if you want to check for any of them you should
compose with `or`. Any `and` and `or` rules may contain more `and` and `or`
rules.

## Example

For example, we can have one rule that will be enabled when customer has an e-mail that contains `@company-mail.com` and is in groups `beta` or `alpha` or is using the application for more than 10 days:

```elixir
%Catraca.Rule.And{
  rules: [
    %Catraca.Rule.Property{
      property: "customer.email",
      condition: :contains,
      value: "@company-mail.com"
    },
    %Catraca.Rule.Or{
      rules: [
        %Catraca.Rule.Property{
          property: "customer.group",
          condition: :in,
          value: ["beta", "alpha"]
        },
        %Catraca.Rule.Property{
          property: "customer.days_using_app",
          condition: :gt,
          value: 10
        }
      ]
    }
  ]
}
```

# HTTP Application

This project provides an HTTP application with an ETS storage (using Etso). You can experiment creating, modifying and evaluating features.

## Creating a feature

```bash
curl localhost:4001/v1/feature \
  -H "Content-Type: application/json" \
  --data '{
    "key": "app.feature",
    "rule": {
      "and": [{
        "property": "customer.email",
        "condition": "contains",
        "value": "@company-mail.com"
      }, {
        "or": [{
          "property": "customer.group",
          "condition": "in",
          "value": ["beta", "alpha"]
        }, {
          "property": "customer.days_using_app",
          "condition": "gt",
          "value": 10
        }]
      }]
    }
  }'
```

## Evaluating a feature

```bash
curl localhost:4001/v1/feature/app.feature/eval \
  -H "Content-Type: application/json" \
  --data '{
    "customer": {
      "email": "person@company-mail.com",
      "group": "beta",
      "days_using_app": 15
    }
  }'
```

In this example, the feature comes enabled because all rules evaluate to
true. You may try changing the properties to check return values.