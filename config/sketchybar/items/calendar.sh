#!/bin/bash

calendar=(
  icon="$CALENDAR"
  icon.font="$ICON_FONT:Regular:13.0"
  icon.color="$BLUE"
  icon.y_offset=1
  label.font="$LABEL_FONT:Bold:11.0"
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
