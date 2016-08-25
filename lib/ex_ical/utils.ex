defmodule ExIcal.Utils do
  alias ExIcal.{Recurrence,Event}
  alias Timex.{Date,DateTime}

  @spec by_range([%Event{}], %DateTime{}, %DateTime{}) :: [%Event{}]
  def by_range(events, start_date, end_date) do
    events |> Recurrence.add_recurring_events(end_date) |> Enum.filter(fn(event) ->
      date_after?(event.start, start_date) && date_before?(event.start, end_date) && date_after?(event.end, start_date) && date_before?(event.end, end_date)
    end) |> sort_by_date
  end

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
