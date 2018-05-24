defmodule ExIcal.Event do
  @moduledoc """
  Represents an iCalendar event.

  For more information on iCalendar events, please see the official specs
  ([RFC 2445]). Here is a brief summary of the available properties of
  `ExIcal.Event` as well as links for more detailed information:

  ## Fields

    - `start`:
      Specifies when the event begins. Corresponds to the iCal `DTSTART`
      property ([4.8.2.4 Date/Time Start]).

    - `end`:
      Specifies the date and time that an event ends. Corresponds to the iCal
      `DTEND` property ([4.8.2.2 Date/Time End]).

    - `stamp`:
      Indicates the date/time that the instance of the iCalendar object was
      created; this must be specified in UTC format. Corresponds to the iCal
      `DTSTAMP` property ([4.8.7.2 Date/Time Stamp]).

    - `description`:
      Provides a more complete description of the event than `summary`.
      Corresponds to the iCal `DESCRIPTION` property ([4.8.1.5 Description]).

    - `summary`:
      Defines a short summary or subject for the event. Corresponds to the iCal
      `SUMMARY` property ([4.8.1.12 Summary]).

    - `rrule`:
      Defines a rule or repeating pattern for recurring events. Corresponds to
      the iCal `RRULE` property ([4.8.5.4 Recurrence Rule]).

    - `categories`:
      Defines the categories for a calendar component. Corresponds to
      the iCal `CATEGORIES` property ([4.8.1.2 Categories Rule]).

    - `uid`:
      Defines the persistent, globally unique identifier for the calendar component.
      Corresponds to the iCal `UID` property ([4.8.4.7 Unique Identifier]).

  [RFC 2445]: https://www.ietf.org/rfc/rfc2445.txt
  [4.8.2.4 Date/Time Start]:   http://www.kanzaki.com/docs/ical/dtstart.html
  [4.8.2.2 Date/Time End]:     http://www.kanzaki.com/docs/ical/dtend.html
  [4.8.7.2 Date/Time Stamp]:   http://www.kanzaki.com/docs/ical/dtstamp.html
  [4.8.1.5 Description]:       http://www.kanzaki.com/docs/ical/description.html
  [4.8.1.12 Summary]:          http://www.kanzaki.com/docs/ical/summary.html
  [4.8.5.4 Recurrence Rule]:   http://www.kanzaki.com/docs/ical/rrule.html
  [4.8.1.2 Categories Rule]:   https://www.kanzaki.com/docs/ical/categories.html
  [4.8.4.7 Unique Identifier]: https://www.kanzaki.com/docs/ical/uid.html

  While this covers many of the commonly-used properties of an iCal `VEVENT`,
  `ExIcal` does not yet have full coverage of all valid properties. More
  properties will be added over time, but if you need a legal iCalendar
  property that `ExIcal` does not yet support, please submit an issue on GitHub.
  """
  defstruct start: nil,
            end: nil,
            stamp: nil,
            description: nil,
            summary: nil,
            rrule: nil,
            categories: nil,
            uid: nil
end
