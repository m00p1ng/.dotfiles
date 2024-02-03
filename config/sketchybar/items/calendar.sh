#!/bin/bash

calendar=(
  icon.drawing=off
  label.font.size=11.0
  label.color="$WHITE"
  label.padding_left=3
  label.padding_right=5
  update_freq=30
  background.corner_radius=6
  background.height=20
  blur_radius=30
  script="$PLUGIN_DIR/calendar.sh"
)
sketchybar --add item calendar right \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
