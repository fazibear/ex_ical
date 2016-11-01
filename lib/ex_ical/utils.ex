defmodule ExIcal.Utils do
  @moduledoc """
  Contains helper functions for events lists.

  `by_range/3` filters a list of events by a date range, and `sort_by_date/1`
  sorts them by start date.
  """

  alias ExIcal.{Recurrence,Event}
  alias Timex.{Date,DateTime}

  @doc """
  Returns all events that fall in the given date range, ordered by start date.

  ## Parameters
    - `events`:     Events list
    - `start_date`: Filter events after this date
    - `end_date`:   Filter events before this date
  """

  @spec by_range([%Event{}], %DateTime{}, %DateTime{}) :: [%Event{}]
  def by_range(events, start_date, end_date) do
    date_in_range = fn(event) ->
      date_after?(event.start, start_date) &&
      date_before?(event.start, end_date) &&
      date_after?(event.end, start_date) &&
      date_before?(event.end, end_date)
    end

    events
    |> Recurrence.add_recurring_events(end_date)
    |> Enum.filter(date_in_range)
    |> sort_by_date
  end

  @doc """
  Sort events by start date/time, earliest to latest.

  ## Parameters
    - `events`: Events list
  """

  @spec sort_by_date([%Event{}]) :: [%Event{}]
  def sort_by_date(events) do
    events |> Enum.sort(fn(event1, event2) ->
      date_before?(event1.start, event2.start)
    end)
  end

  defp date_before?(date1, date2) do
    case Date.compare(date1, date2) do
      -1 -> true
      0  -> true
      1  -> false
    end
  end

  defp date_after?(date1, date2) do
    case Date.compare(date1, date2) do
      -1 -> false
      0  -> true
      1  -> true
    end
  end
end
