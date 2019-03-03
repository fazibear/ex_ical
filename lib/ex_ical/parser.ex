defmodule ExIcal.Parser do
  @moduledoc """
  Responsible for parsing an iCal string into a list of events.

  This module contains one public function, `parse/1`.

  Most of the most frequently used iCalendar properties can be parsed from the
  file (for example: start/end time, description, recurrence rules, and more;
  see `ExIcal.Event` for a full list).

  However, there is not yet full coverage of all properties available in the
  iCalendar spec. More properties will be added over time, but if you need a
  legal iCalendar property that `ExIcal` does not yet support, please sumbit an
  issue on GitHub.
  """

  alias ExIcal.{DateParser,Event}

  @doc """
  Parses an iCal string into a list of events.

  This function takes a single argument–a string in iCalendar format–and returns
  a list of `%ExIcal.Event{}`.

  ## Example

  ```elixir
  HTTPotion.get("url-for-icalendar").body
    |> ExIcal.parse
    |> ExIcal.by_range(DateTime.utc_now(), DateTime.utc_now() |> Timex.shift(days: 7))
  ```
  """

  @spec parse(String.t) :: [%Event{}]
  def parse(data) do
    data
    |> String.replace(~s"\n\t", ~S"\n")
    |> String.replace(~s"\n\x20", ~S"\n")
    |> String.replace(~s"\"", "")
    |> String.split("\n")
    |> Enum.reduce(%{events: []}, fn(line, data) ->
      line
      |> String.trim() 
      |> parse_line(data)
    end)
    |> Map.get(:events)
  end

  defp parse_line("BEGIN:VEVENT" <> _, data),           do: %{data | events: [%Event{} | data[:events]]}
  defp parse_line("DTSTART" <> start, data),            do: data |> put_to_map(:start, process_date(start, data[:tzid]))
  defp parse_line("DTEND" <> endd, data),               do: data |> put_to_map(:end, process_date(endd, data[:tzid]))
  defp parse_line("DTSTAMP" <> stamp, data),            do: data |> put_to_map(:stamp, process_date(stamp, data[:tzid]))
  defp parse_line("SUMMARY:" <> summary, data),         do: data |> put_to_map(:summary, process_string(summary))
  defp parse_line("DESCRIPTION:" <> description, data), do: data |> put_to_map(:description, process_string(description))
  defp parse_line("UID:" <> uid, data),                 do: data |> put_to_map(:uid, uid)
  defp parse_line("RRULE:" <> rrule, data),             do: data |> put_to_map(:rrule, process_rrule(rrule, data[:tzid]))
  defp parse_line("TZID:" <> tzid, data),               do: data |> Map.put(:tzid, tzid)
  defp parse_line("CATEGORIES:" <> categories, data),    do: data |> put_to_map(:categories, String.split(categories, ","))
  defp parse_line(_, data), do: data

  defp put_to_map(%{events: [event | events]} = data, key, value) do
    updated_event = %{event | key => value}
    %{data | events: [updated_event | events]}
  end
  defp put_to_map(data, _key, _value), do: data

  defp process_date(":" <> date, tzid), do: DateParser.parse(date, tzid)
  defp process_date(";" <> date, _) do
    [timezone, date] = date |> String.split(":")
    timezone = case timezone do
      "TZID=" <> timezone -> timezone
      _ -> nil
    end
    DateParser.parse(date, timezone)
  end

  defp process_rrule(rrule, tzid) do
    rrule |> String.split(";") |> Enum.reduce(%{}, fn(rule, hash) ->
      [key, value] = rule |> String.split("=")
      case key |> String.downcase |> String.to_atom do
        :until    -> hash |> Map.put(:until, DateParser.parse(value, tzid))
        :interval -> hash |> Map.put(:interval, String.to_integer(value))
        :count    -> hash |> Map.put(:count, String.to_integer(value))
        :freq     -> hash |> Map.put(:freq, value)
        _         -> hash
      end
    end)
  end

  defp process_string(string) when is_binary(string) do
    string
    |> String.replace(~S",", ~s",")
    |> String.replace(~S"\n", ~s"\n")
  end
end
