#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  label.y_offset=-1.5
  padding_right=3
  padding_left=1
  y_offset=1
  update_freq=120
  updates=on
)

sketchybar --add item battery right \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke
