#!/bin/bash

time=(
  icon.font="$ICON_FONT:Regular:14.0"
  icon.color="$BLACK"
  label.font="$LABEL_FONT:Bold:12.0"
  label.color="$BLACK"
  label.padding_right=8
  label.padding_left=0
  background.y_offset=1
  label.y_offset=1
  label.align=right
  update_freq=30
  padding_left=0
  script="$PLUGIN_DIR/time.sh"
  background.color="$YELLOW"
  background.corner_radius=6
  background.height=20
  blur_radius=30
)

sketchybar --add item time right       \
           --set time "${time[@]}" \
           --subscribe time
