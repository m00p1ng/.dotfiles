#!/bin/bash

meeting_query() {
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
    'map(select(.endDate > $now)) | first // empty'
}
