#!/bin/bash

input=(
  script="$PLUGIN_DIR/input.sh"
  icon=􀇳
  icon.font="$ICON_FONT:Regular:17.0"
  icon.color="$RED"
  label.font="$LABEL_FONT:16.0"
  padding_left=4
  icon.y_offset=1
)
sketchybar --add event input_change 'AppleSelectedInputSourcesChangedNotification' \
    --add item input right \
    --set input "${input[@]}" \
    --subscribe input input_change
