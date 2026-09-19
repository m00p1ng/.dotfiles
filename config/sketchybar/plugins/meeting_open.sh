#!/bin/bash
# Jumps into the meeting shown on the bar, or falls back to Calendar.

source "$CONFIG_DIR/plugins/meeting_query.sh"

url="$(meeting_query | jq -r '.meetingUrl // empty')"

if [[ -n "$url" ]]; then
  open "$url"
else
  open -a Calendar
fi
