#!/bin/bash

time=(
  label="$(date '+%H:%M')"
)
sketchybar --set "$NAME" "${time[@]}"
