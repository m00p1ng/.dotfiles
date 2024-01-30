#!/bin/bash

calendar=(
  icon.font="$ICON_FONT:Regular:13.0"
  icon.y_offset=1
  icon.color="$BLUE"
  label.color="$WHITE"
  label.font="$LABEL_FONT:Bold:11.0"
  label.padding_left=3
  label.padding_right=5
  update_freq=30
  script="$PLUGIN_DIR/calendar.sh"
  background.corner_radius=6
  background.height=20
  blur_radius=30
)
sketchybar --add item calendar right \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
