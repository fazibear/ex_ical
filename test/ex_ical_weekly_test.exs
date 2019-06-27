defmodule ExIcalWeeklyTest do
  use ExUnit.Case
  import ExIcal.Test.Utils

  test "weekly reccuring event with until" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=WEEKLY;UNTIL=20160201T083000Z"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 6

    assert_start_times(events, [
      "20151224T083000Z",
      "20151231T083000Z",
      "20160107T083000Z",
      "20160114T083000Z",
      "20160121T083000Z",
      "20160128T083000Z"
    ])
  end

  test "weekly reccuring event" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=WEEKLY"
    )
    events = ical |> events_between("20151224T083000Z", "20160121T084500Z")
    assert events |> Enum.count == 5

    assert_start_times(events, [
      "20151224T083000Z",
      "20151231T083000Z",
      "20160107T083000Z",
      "20160114T083000Z",
      "20160121T083000Z"
    ])
  end

  test "weekly reccuring event with until and interval" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=WEEKLY;UNTIL=20161224T083000Z;INTERVAL=8"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 7

    assert_start_times(events, [
      "20151224T083000Z",
      "20160218T083000Z",
      "20160414T083000Z",
      "20160609T083000Z",
      "20160804T083000Z",
      "20160929T083000Z",
      "20161124T083000Z"
    ])
  end

  test "weekly reccuring event with count" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=WEEKLY;COUNT=5"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 6

    assert_start_times(events, [
      "20151224T083000Z",
      "20151231T083000Z",
      "20160107T083000Z",
      "20160114T083000Z",
      "20160121T083000Z",
      "20160128T083000Z"
    ])
  end

  test "weekly reccuring event with count and interval" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=WEEKLY;COUNT=4;INTERVAL=8"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 5

    assert_start_times(events, [
      "20151224T083000Z",
      "20160218T083000Z",
      "20160414T083000Z",
      "20160609T083000Z",
      "20160804T083000Z"
    ])
  end

  test "weekly reccuring event with interval" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=WEEKLY;INTERVAL=8"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 7

    assert_start_times(events, [
      "20151224T083000Z",
      "20160218T083000Z",
      "20160414T083000Z",
      "20160609T083000Z",
      "20160804T083000Z",
      "20160929T083000Z",
      "20161124T083000Z"
    ])
  end
end
