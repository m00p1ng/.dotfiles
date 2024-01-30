#!/bin/bash

calendar=(
  label="$(date '+%a %d. %b')"
)
sketchybar --set "$NAME" "${calendar[@]}"
