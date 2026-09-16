#!/bin/bash
# Opens the meeting link of the next event shown by meeting.sh.

# PLUGIN_DIR is not exported to spawned scripts; only CONFIG_DIR is.
source "$CONFIG_DIR/plugins/meeting_query.sh"

event="$(meeting_query)"
URL="$(jq -r '.meetingUrl // empty' <<<"$event")"

if [[ -n "$URL" ]]; then
  open "$URL"
else
  open -a Calendar
fi
