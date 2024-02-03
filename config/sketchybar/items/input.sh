#!/bin/bash

input=(
  icon="$KEYBOARD"
  icon.font.size=17.0
  icon.color="$RED"
  icon.y_offset=1
  padding_left=4
  script="$PLUGIN_DIR/input.sh"
)
sketchybar --add event input_change 'AppleSelectedInputSourcesChangedNotification' \
           --add item input right \
           --set input "${input[@]}" \
           --subscribe input input_change
