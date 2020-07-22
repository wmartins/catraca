defmodule Catraca.ComparisonTest do
  use ExUnit.Case
  doctest Catraca.Comparison

  describe "equality" do
    test "checks when a value is equal another" do
      assert Catraca.Comparison.compare("string", :eq, "string")
    end

    test "checks when a valuse is not equal another" do
      refute Catraca.Comparison.compare("string", :eq, "other string")
    end
  end

  describe "greater than" do
    test "checks when value is greater than other" do
      assert Catraca.Comparison.compare(10, :gt, 5)
    end

    test "checks when value is not greather than other" do
      refute Catraca.Comparison.compare(5, :gt, 10)
    end
  end

  describe "less than" do
    test "checks when value is less than other" do
      assert Catraca.Comparison.compare(30, :lt, 50)
    end

    test "checks when value is not greather than other" do
      refute Catraca.Comparison.compare(50, :lt, 30)
    end
  end

  describe "contains" do
    test "checks when a value contains another" do
      assert Catraca.Comparison.compare("some@email.com", :contains, "@email.com")
    end

    test "checks when a value doesn't contain another" do
      refute Catraca.Comparison.compare("some@email.com", :contains, "@otheremail.com")
    end

    test "returns false when comparing to nil" do
      refute Catraca.Comparison.compare(nil, :contains, "@email.com")
    end

    test "returns false when comparing nil to nil" do
      refute Catraca.Comparison.compare(nil, :contains, nil)
    end
  end

  describe "in" do
    test "checks when a value includes another" do
      assert Catraca.Comparison.compare("A", :in, ["A", "B", "C"])
    end

    test "checks when a value doesn't include another" do
      refute Catraca.Comparison.compare("D", :in, ["A", "B", "C"])
    end
  end
end
