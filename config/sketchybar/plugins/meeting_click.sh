#!/bin/bash

source "$CONFIG_DIR/plugins/meeting_query.sh"

event="$(meeting_query)"
url="$(jq -r '.meetingUrl // empty' <<<"$event")"

if [[ -n "$url" ]]; then
  open "$url"
else
  open -a Calendar
fi
