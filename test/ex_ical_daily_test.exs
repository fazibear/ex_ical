defmodule ExIcalDailyTest do
  use ExUnit.Case
  import ExIcal.Test.Utils

  test "daily reccuring event with until" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=DAILY;UNTIL=20151231T083000Z"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 8

    assert_start_times(events, [
      "20151224T083000Z",
      "20151225T083000Z",
      "20151226T083000Z",
      "20151227T083000Z",
      "20151228T083000Z",
      "20151229T083000Z",
      "20151230T083000Z",
      "20151231T083000Z"
    ])
  end

  test "daily reccuring event" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=DAILY"
    )
    events = ical |> events_between("20151224T083000Z", "20151230T084500Z")
    assert events |> Enum.count == 7

    assert_start_times(events, [
      "20151224T083000Z",
      "20151225T083000Z",
      "20151226T083000Z",
      "20151227T083000Z",
      "20151228T083000Z",
      "20151229T083000Z",
      "20151230T083000Z"
    ])
  end

  test "daily reccuring event with until and interval" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=DAILY;UNTIL=20151231T083000Z;INTERVAL=3"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 3

    assert_start_times(events, [
      "20151224T083000Z",
      "20151227T083000Z",
      "20151230T083000Z"
    ])
  end

  test "daily reccuring event with count" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=DAILY;COUNT=5"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 6

    assert_start_times(events, [
      "20151224T083000Z",
      "20151225T083000Z",
      "20151226T083000Z",
      "20151227T083000Z",
      "20151228T083000Z",
      "20151229T083000Z"
    ])
  end

  test "daily reccuring event with count and interval" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=DAILY;COUNT=5;INTERVAL=2"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 6

    assert_start_times(events, [
      "20151224T083000Z",
      "20151226T083000Z",
      "20151228T083000Z",
      "20151230T083000Z",
      "20160101T083000Z",
      "20160103T083000Z"
    ])
  end

  test "daily reccuring event with interval" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=DAILY;INTERVAL=2"
    )
    events = ical |> events_between("20151224T083000Z", "20151231T084500Z")
    assert events |> Enum.count == 4

    assert_start_times(events, [
      "20151224T083000Z",
      "20151226T083000Z",
      "20151228T083000Z",
      "20151230T083000Z"
    ])
  end
end
