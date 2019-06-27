defmodule ExIcalYearlyTest do
  use ExUnit.Case
  import ExIcal.Test.Utils
  alias ExIcal.DateParser

  test "yearly reccuring event with until" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=YEARLY;UNTIL=20201224T083000Z"
    )
    events = ical |> events_between("20151224T083000Z", "20201224T084500Z")
    assert events |> Enum.count == 6

    assert_start_times(events, [
      "20151224T083000Z",
      "20161224T083000Z",
      "20171224T083000Z",
      "20181224T083000Z",
      "20191224T083000Z",
      "20201224T083000Z",
    ])
  end

  test "yearly recurring event" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=YEARLY"
    )
    events = ical |> events_between("20151224T083000Z", "20171225T083000Z")
    assert events |> Enum.count == 3

    assert_start_times(events, [
      "20151224T083000Z",
      "20161224T083000Z",
      "20171224T083000Z",
    ])
  end

  test "yearly reccuring event with until and interval" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=YEARLY;UNTIL=20251224T083000Z;INTERVAL=2"
    )
    events = ical |> events_between("20151224T083000Z", "20251224T084500Z")
    assert events |> Enum.count == 6

    assert_start_times(events, [
      "20151224T083000Z",
      "20171224T083000Z",
      "20191224T083000Z",
      "20211224T083000Z",
      "20231224T083000Z",
      "20251224T083000Z"
    ])
  end

  test "yearly reccuring event with count" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=YEARLY;COUNT=5"
    )
    events = ical |> events_between("20151224T083000Z", "20251224T084500Z")
    assert events |> Enum.count == 6

    assert_start_times(events, [
      "20151224T083000Z",
      "20161224T083000Z",
      "20171224T083000Z",
      "20181224T083000Z",
      "20191224T083000Z",
      "20201224T083000Z",
    ])
  end

  test "yearly reccuring event with count and interval" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=YEARLY;COUNT=4;INTERVAL=8"
    )
    events = ical |> events_between("20151224T083000Z", "20501224T084500Z")

    assert events |> Enum.count == 5

    assert_start_times(events, [
      "20151224T083000Z",
      "20231224T083000Z",
      "20311224T083000Z",
      "20391224T083000Z",
      "20471224T083000Z",
    ])
  end

  test "yearly reccuring event with interval" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=YEARLY;INTERVAL=3"
    )
    events = ical |> events_between("20151224T083000Z", "20301224T084500Z")
    assert events |> Enum.count == 6

    assert_start_times(events, [
      "20151224T083000Z",
      "20181224T083000Z",
      "20211224T083000Z",
      "20241224T083000Z",
      "20271224T083000Z",
      "20301224T083000Z",
    ])
  end
end
