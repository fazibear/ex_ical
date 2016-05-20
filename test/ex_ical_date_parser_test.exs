defmodule ExIcalDateParserTest do
  use ExUnit.Case
  use Timex

  alias ExIcal.DateParser

  doctest ExIcal

  test "parse date time (+zone) without timezone" do
    assert Timex.Date.equal?(DateParser.parse("20160518T140530Z"), Timex.Date.from({{2016, 5, 18}, {14, 5, 30}}, :utc))
  end

  test "parse date time (+zone) with timezone" do
    assert Timex.Date.equal?(DateParser.parse("20160518T140530Z", "Europe/Berlin"), Timex.Date.from({{2016, 5, 18}, {14, 5, 30}}, "Europe/Berlin"))
  end

  test "parse date without (+zone) timezone" do
    assert Timex.Date.equal?(DateParser.parse("20160518Z"), Timex.Date.from({2016, 5, 18}, :utc))
  end

  test "parse date with (+zone) timezone" do
    assert Timex.Date.equal?(DateParser.parse("20160518Z", "Europe/Berlin"), Timex.Date.from({2016, 5, 18}, "Europe/Berlin"))
  end

  test "parse date time without timezone" do
    assert Timex.Date.equal?(DateParser.parse("20160518T140530"), Timex.Date.from({{2016, 5, 18}, {14, 5, 30}}, :utc))
  end

  test "parse date time with timezone" do
    assert Timex.Date.equal?(DateParser.parse("20160518T140530", "Europe/Berlin"), Timex.Date.from({{2016, 5, 18}, {14, 5, 30}}, "Europe/Berlin"))
  end

  test "parse date without timezone" do
    assert Timex.Date.equal?(DateParser.parse("20160518"), Timex.Date.from({2016, 5, 18}, :utc))
  end

  test "parse date with timezone" do
    assert Timex.Date.equal?(DateParser.parse("20160518", "Europe/Berlin"), Timex.Date.from({2016, 5, 18}, "Europe/Berlin"))
  end
end