defmodule ExIcal.Parser do
  alias ExIcal.{DateParser,Event}

  @spec parse(String.t) :: [%Event{}]
  def parse(data) do
    data
    |> String.split("\n")
    |> Enum.reduce(%{events: []}, fn(line, data) ->
      parse_line(String.strip(line), data)
    end)
    |> Map.get(:events)
  end

  defp parse_line("BEGIN:VEVENT" <> _, data),           do: %{data | events: [%Event{} | data[:events]]}
  defp parse_line("DTSTART" <> start, data),            do: data |> put_to_map(:start, process_date(start, data[:tzid]))
  defp parse_line("DTEND" <> endd, data),               do: data |> put_to_map(:end, process_date(endd, data[:tzid]))
  defp parse_line("DTSTAMP" <> stamp, data),            do: data |> put_to_map(:stamp, process_date(stamp, data[:tzid]))
  defp parse_line("SUMMARY:" <> summary, data),         do: data |> put_to_map(:summary, summary)
  defp parse_line("DESCRIPTION:" <> description, data), do: data |> put_to_map(:description, description)
  defp parse_line("RRULE:" <> rrule, data),             do: data |> put_to_map(:rrule, process_rrule(rrule, data[:tzid]))
  defp parse_line("TZID:" <> tzid, data),               do: data |> Map.put(:tzid, tzid)
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
end
