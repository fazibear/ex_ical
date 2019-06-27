ExUnit.start()

defmodule ExIcal.Test.Utils do
  alias ExIcal.DateParser

  def subset?(nil, nil), do: true
  def subset?(nil, _), do: false
  def subset?(_, nil), do: false
  def subset?("" <> subset, "" <> superset) do
    String.contains?(superset, subset)
  end
  def subset?(%{} = subset, %{} = superset) do
    superset_contains_pair = fn {k, v} ->
      %{superset | k => v} === superset
    end
    subset |> Enum.all?(superset_contains_pair)
  end

  defmacro assert_subset(subset, superset) do
    quote do
      assert subset?(unquote(subset), unquote(superset)),
        "Expected #{inspect unquote(subset)} to be a subset of #{inspect unquote(superset)}"
    end
  end

  def generate_ical(dtstart: dtstart, dtend: dtend, rrule: rrule) do
    """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:#{rrule}
    DESCRIPTION:Let's go see Star Wars.
    DTEND:#{dtend}
    DTSTART:#{dtstart}
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
  end

  def events_between(ical, start_date, end_date) do
    ical
    |> ExIcal.parse()
    |> ExIcal.by_range(
      DateParser.parse(start_date),
      DateParser.parse(end_date)
    )
  end

  defmacro assert_start_times(events, expected_times) do
    quote do
      events_starting_at = unquote(events) |> Enum.map(& &1.start)

      assert events_starting_at == unquote(expected_times) |> Enum.map(&DateParser.parse/1)
    end
  end
end
