defmodule ExIcal.DateParser do
  use Timex

  def parse(data), do: parse(data, nil)

  def parse(data, timezone) when is_nil(timezone), do: parse(data, :utc)

  def parse(<< year :: binary-size(4), month :: binary-size(2), day :: binary-size(2), "T",
                        hour :: binary-size(2), minutes :: binary-size(2), seconds :: binary-size(2), "Z" >>, timezone) do
      %DateTime{year: year |> String.to_integer, month: month |> String.to_integer, day: day |> String.to_integer,
                hour: hour |> String.to_integer, minute: minutes |> String.to_integer, second: seconds |> String.to_integer, timezone: Timezone.get(timezone)}
  end

  def parse(<< year :: binary-size(4), month :: binary-size(2), day :: binary-size(2), "Z" >>, timezone) do
      %DateTime{year: year |> String.to_integer, month: month |> String.to_integer, day: day |> String.to_integer, timezone: Timezone.get(timezone)}
  end

  def parse(<< year :: binary-size(4), month :: binary-size(2), day :: binary-size(2), "T",
                        hour :: binary-size(2), minutes :: binary-size(2), seconds :: binary-size(2) >>, timezone) do
      %DateTime{year: year |> String.to_integer, month: month |> String.to_integer, day: day |> String.to_integer,
                hour: hour |> String.to_integer, minute: minutes |> String.to_integer, second: seconds |> String.to_integer, timezone: Timezone.get(timezone)}
  end

  def parse(<< year :: binary-size(4), month :: binary-size(2), day :: binary-size(2) >>, timezone) do
      %DateTime{year: year |> String.to_integer, month: month |> String.to_integer, day: day |> String.to_integer, timezone: Timezone.get(timezone)}
  end
end
