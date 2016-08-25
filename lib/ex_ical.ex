defmodule ExIcal do
  alias ExIcal.{Parser,Recurrence,Utils,Event}
  alias Timex.DateTime

  @spec parse(String.t) :: [%Event{}]
  defdelegate parse(data), to: Parser

  @spec add_recurring_events([%Event{}]) :: [%Event{}]
  defdelegate add_recurring_events(events), to: Recurrence

  @spec add_recurring_events([%Event{}], %DateTime{}) :: [%Event{}]
  defdelegate add_recurring_events(events, end_date), to: Recurrence

  @spec sort_by_date([%Event{}]) :: [%Event{}]
  defdelegate sort_by_date(events), to: Utils

  @spec by_range([%Event{}], %DateTime{}, %DateTime{}) :: [%Event{}]
  defdelegate by_range(events, start_date, end_date), to: Utils
end
