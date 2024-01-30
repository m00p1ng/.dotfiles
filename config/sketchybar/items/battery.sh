#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$ICON_FONT:Regular:18.0"
  label.font="$LABEL_FONT:Regular:12.0"
  padding_right=3
  padding_left=1
  label.y_offset=-1.5
  y_offset=1
  label.drawing=on
  update_freq=120
  updates=on
)

sketchybar --add item battery right \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke
