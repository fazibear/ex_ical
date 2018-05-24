defmodule ExIcalTest do
  use ExUnit.Case
  alias ExIcal.DateParser

  doctest ExIcal

  test "parse empty data" do
    assert ExIcal.parse("") == []
  end

  test "event" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    CATEGORIES:MOVIES,SOCIAL
    UID:19960401T080045Z-4000F192713-0052@host1.com
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical)

    assert events |> Enum.count == 1

    event = events |> List.first

    assert event.description == "Let's go see Star Wars."
    assert event.summary == "Film with Amy and Adam"
    assert event.start == DateParser.parse("20151224T083000Z")
    assert event.end == DateParser.parse("20151224T084500Z")
    assert event.categories == ["MOVIES", "SOCIAL"]
    assert event.uid == "19960401T080045Z-4000F192713-0052@host1.com"
  end

  test "event with escaped characters" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    DESCRIPTION:Let's go\, see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical)

    assert events |> Enum.count == 1

    event = events |> List.first

    assert event.description == "Let's go, see Star Wars."
  end

  test "event with multiline description" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    DESCRIPTION:Let's go!\n\tWanna see Star Wars?\n\x20It's great
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical)

    assert events |> Enum.count == 1

    event = events |> List.first

    assert event.description == "Let's go!\nWanna see Star Wars?\nIt's great"
  end

  test "event with spaces around" do
    ical = """
       BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    DESCRIPTION:Let's go!\n\tWanna see Star Wars?\n\x20It's great
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical)

    assert events |> Enum.count == 1

    event = events |> List.first

    assert event.description == "Let's go!\nWanna see Star Wars?\nIt's great"
    assert event.summary == "Film with Amy and Adam"
    assert event.start == DateParser.parse("20151224T083000Z")
    assert event.end == DateParser.parse("20151224T084500Z")
  end
end
