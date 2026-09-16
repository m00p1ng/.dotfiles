#!/bin/bash
# Opens the meeting link of the next event shown by meeting.sh.
# The link may live in the event's url, location or notes.

# PLUGIN_DIR is not exported to spawned scripts; only CONFIG_DIR is.
source "$CONFIG_DIR/plugins/meeting_query.sh"

MEETING_HOSTS='meet\.google\.com|([a-z0-9-]+\.)?zoom\.us|teams\.(microsoft|live)\.com'

# Trailing punctuation is often calendar prose, not part of the URL.
extract_url() {
  local text="$1"
  local url

  url=$(echo "$text" | grep -Eo "https?://($MEETING_HOSTS)/[^[:space:]]*" | head -1)

  if [[ -z "$url" ]]; then
    url=$(echo "$text" | grep -Eo 'https?://[^[:space:]]+' | head -1)
  fi

  echo "$url" | sed -E "s/[).,;:'\"]+$//"
}

URL="$(extract_url "$(meeting_query "url,location,notes" "url,location,notes")")"

if [[ -n "$URL" ]]; then
  open "$URL"
else
  open -a Calendar
fi
