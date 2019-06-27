defmodule ExIcalMonthlyTest do
  use ExUnit.Case
  import ExIcal.Test.Utils

  test "monthly reccuring event with until" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=MONTHLY;UNTIL=20161224T083000Z"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 13

    assert_start_times(events, [
      "20151224T083000Z",
      "20160124T083000Z",
      "20160224T083000Z",
      "20160324T083000Z",
      "20160424T083000Z",
      "20160524T083000Z",
      "20160624T083000Z",
      "20160724T083000Z",
      "20160824T083000Z",
      "20160924T083000Z",
      "20161024T083000Z",
      "20161124T083000Z",
      "20161224T083000Z"
    ])
  end

  test "monthly reccuring event" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=MONTHLY"
    )
    events = ical |> events_between("20151224T083000Z", "20160924T084500Z")
    assert events |> Enum.count == 10

    assert_start_times(events, [
      "20151224T083000Z",
      "20160124T083000Z",
      "20160224T083000Z",
      "20160324T083000Z",
      "20160424T083000Z",
      "20160524T083000Z",
      "20160624T083000Z",
      "20160724T083000Z",
      "20160824T083000Z",
      "20160924T083000Z"
    ])
  end

  test "monthly reccuring event with until and interval" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=MONTHLY;UNTIL=20161224T083000Z;INTERVAL=3"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 5

    assert_start_times(events, [
      "20151224T083000Z",
      "20160324T083000Z",
      "20160624T083000Z",
      "20160924T083000Z",
      "20161224T083000Z"
    ])
  end

  test "monthly reccuring event with count" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=MONTHLY;COUNT=5"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 6

    assert_start_times(events, [
      "20151224T083000Z",
      "20160124T083000Z",
      "20160224T083000Z",
      "20160324T083000Z",
      "20160424T083000Z",
      "20160524T083000Z"
    ])
  end

  test "monthly reccuring event with count and interval" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=MONTHLY;COUNT=5;INTERVAL=2"
    )
    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 6

    assert_start_times(events, [
      "20151224T083000Z",
      "20160224T083000Z",
      "20160424T083000Z",
      "20160624T083000Z",
      "20160824T083000Z",
      "20161024T083000Z"
    ])
  end

  test "monthly reccuring event with interval" do
    ical = generate_ical(
      dtstart: "20151224T083000Z",
      dtend: "20151224T084500Z",
      rrule: "FREQ=MONTHLY;INTERVAL=2"
    )

    events = ical |> events_between("20151224T083000Z", "20161224T084500Z")
    assert events |> Enum.count == 7

    assert_start_times(events, [
      "20151224T083000Z",
      "20160224T083000Z",
      "20160424T083000Z",
      "20160624T083000Z",
      "20160824T083000Z",
      "20161024T083000Z",
      "20161224T083000Z"
    ])
  end
end
