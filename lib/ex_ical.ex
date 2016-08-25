defmodule ExIcal do
  alias ExIcal.Parser
  alias ExIcal.Recurrence
  alias ExIcal.Utils

  @spec parse(String.t) :: [%ExIcal.Event{}]
  defdelegate parse(data), to: Parser

  @spec add_recurring_events([%ExIcal.Event{}]) :: [%ExIcal.Event{}]
  defdelegate add_recurring_events(events), to: Recurrence

  @spec add_recurring_events([%ExIcal.Event{}], %Timex.DateTime{}) :: [%ExIcal.Event{}]
  defdelegate add_recurring_events(events, end_date), to: Recurrence

  @spec sort_by_date([%ExIcal.Event{}]) :: [%ExIcal.Event{}]
  defdelegate sort_by_date(events), to: Utils

  @spec by_range([%ExIcal.Event{}], %Timex.DateTime{}, %Timex.DateTime{}) :: [%ExIcal.Event{}]
  defdelegate by_range(events, start_date, end_date), to: Utils
end
