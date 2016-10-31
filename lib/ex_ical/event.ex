defmodule ExIcal.Event do
  @moduledoc """
  Ical event representation.

  ## Fields
    - start: Start event
    - end: End event
    - stamp:
    - description: Event description
    - summary: Event summary
    - rrute: Reccurence rule
  """
  defstruct start: nil,
            end: nil,
            stamp: nil,
            description: nil,
            summary: nil,
            rrule: nil
end
