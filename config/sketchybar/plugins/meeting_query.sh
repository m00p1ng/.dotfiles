#!/bin/bash
# Single definition of "the next meeting", shared by meeting.sh and meeting_click.sh
# so the widget and its click action always act on the same event.
#
# Prints one compact JSON event. The query includes an event already in progress,
# then the next upcoming event, but never a completed event or an all-day event.

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
