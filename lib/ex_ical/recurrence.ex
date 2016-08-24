defmodule ExIcal.Recurrence do
  alias Timex.{Date,DateTime}

  def add_recurring_events(events, end_date \\ Date.now) do
    events ++ (events |> Enum.reduce([], fn(event, revents) ->
      case event.rrule do
        nil ->
          revents
        %{freq: "DAILY", count: count, interval: interval} ->
          revents ++ (event |> add_recurring_events_count(count, [days: interval]))
        %{freq: "DAILY", until: until, interval: interval} ->
          revents ++ (event |> add_recurring_events_until(until, [days: interval]))
        %{freq: "DAILY", count: count} ->
          revents ++ (event |> add_recurring_events_count(count, [days: 1]))
        %{freq: "DAILY", until: until} ->
          revents ++ (event |> add_recurring_events_until(until, [days: 1]))
        %{freq: "DAILY", interval: interval} ->
          revents ++ (event |> add_recurring_events_until(end_date, [days: interval]))
        %{freq: "DAILY"} ->
          revents ++ (event |> add_recurring_events_until(end_date, [days: 1]))


        %{freq: "WEEKLY", count: count, interval: interval} ->
          revents ++ (event |> add_recurring_events_count(count, [days: interval * 7]))
        %{freq: "WEEKLY", until: until, interval: interval} ->
          revents ++ (event |> add_recurring_events_until(until, [days: interval * 7]))
        %{freq: "WEEKLY", count: count} ->
          revents ++ (event |> add_recurring_events_count(count, [days: 7]))
        %{freq: "WEEKLY", until: until} ->
          revents ++ (event |> add_recurring_events_until(until, [days: 7]))
        %{freq: "WEEKLY", interval: interval} ->
          revents ++ (event |> add_recurring_events_until(end_date, [days: interval * 7]))
        %{freq: "WEEKLY"} ->
          revents ++ (event |> add_recurring_events_until(end_date, [days: 7]))


        %{freq: "MONTHLY", count: count, interval: interval} ->
          revents ++ (event |> add_recurring_events_count(count, [months: interval]))
        %{freq: "MONTHLY", until: until, interval: interval} ->
          revents ++ (event |> add_recurring_events_until(until, [months: interval]))
        %{freq: "MONTHLY", count: count} ->
          revents ++ (event |> add_recurring_events_count(count, [months: 1]))
        %{freq: "MONTHLY", until: until} ->
          revents ++ (event |> add_recurring_events_until(until, [months: 1]))
        %{freq: "MONTHLY", interval: interval} ->
          revents ++ (event |> add_recurring_events_until(end_date, [months: interval]))
        %{freq: "MONTHLY"} ->
          revents ++ (event |> add_recurring_events_until(end_date, [months: 1]))
      end
    end))
  end

  defp add_recurring_events_until(event, until, shift_opts) do
    new_event = shift_event(event, shift_opts)

    case Date.compare(new_event.start, until) do
     -1 -> [new_event] ++ add_recurring_events_until(new_event, until, shift_opts)
      0 -> [new_event]
      1 -> []
    end
  end

  defp add_recurring_events_count(event, count, shift_opts) do
    new_event = shift_event(event, shift_opts)
    if count > 1 do
      [new_event] ++ add_recurring_events_count(new_event, count - 1, shift_opts)
    else
      [new_event]
    end
  end

  defp shift_event(event, shift_opts) do
    new_event = event
    new_event = %{new_event | start: Date.shift(event.start, shift_opts)}
    new_event = %{new_event | end: Date.shift(event.end, shift_opts)}
    new_event
  end
end
