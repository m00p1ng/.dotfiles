#!/bin/bash

source "$CONFIG_DIR/icons.sh"

calendar=(
  icon="$CALENDAR"
  label="$(date '+%a %d. %b')"
)
sketchybar --set "$NAME" "${calendar[@]}"
