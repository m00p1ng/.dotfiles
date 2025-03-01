#!/bin/bash

time=(
  icon.drawing=off
  label.font.style=Bold
  label.font.size=12.0
  label.color="$BLACK"
  label.padding_right=8
  label.padding_left=8
  label.y_offset=1
  label.align=right
  background.color="$YELLOW"
  background.corner_radius=6
  background.height=20
  background.y_offset=1
  update_freq=5
  padding_left=0
  script="$PLUGIN_DIR/time.sh"
  click_script="$PLUGIN_DIR/time.sh"
)

sketchybar --add item time right \
  --set time "${time[@]}" \
  --subscribe time
