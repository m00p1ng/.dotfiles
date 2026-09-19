#!/bin/bash

meeting_events() {
  local filter="${1:-.}"
  local args=(
    events
    --format json
    --no-color
    --group-by none
    --exclude-all-day
  )

  if [[ -n "$SKETCHYBAR_WIDGET_MEETING_CALENDARS" ]]; then
    args+=(--include-calendars "$SKETCHYBAR_WIDGET_MEETING_CALENDARS")
  fi

  ical-guy "${args[@]}" | jq -c --arg now "$(/bin/date -u +%Y-%m-%dT%H:%M:%SZ)" \
    "map(select(.endDate > \$now)) | sort_by(.startDate) | $filter"
}

# The event the bar item itself shows: the next one that has not ended yet.
meeting_query() {
  meeting_events '.[0] // empty'
}
