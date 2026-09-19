#!/bin/bash
# Expands or collapses one section of the meeting popup, such as the attendees
# or the notes of a single event. Called from that section's header row, see
# plugins/meeting_popup.sh.

source "$CONFIG_DIR/icons.sh"

group="$1"  # meeting.popup.<att|note>.<event>
header="$2" # meeting.popup.<att|note>head.<event>.<line>

[[ -z "$group" || -z "$header" ]] && exit 0

# Item names are matched as a regex, so their dots have to be escaped.
members="/${group//./\\.}\\..*/"

# The header's own chevron is the record of whether its section is open.
if [[ "$(sketchybar --query "$header" | jq -r '.icon.value')" == "$CHEVRON_RIGHT" ]]; then
  drawing=on
  chevron="$CHEVRON_DOWN"
else
  drawing=off
  chevron="$CHEVRON_RIGHT"
fi

sketchybar --set "$members" drawing="$drawing" --set "$header" icon="$chevron"
