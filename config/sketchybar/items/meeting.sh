#!/bin/bash

meeting=(
  label.y_offset=-1.5
  padding_right=4
  padding_left=4
  y_offset=1
  script="$PLUGIN_DIR/meeting.sh"
  click_script="$PLUGIN_DIR/meeting_click.sh"
  update_freq=1
  updates=on
)

# Label is filled in by plugins/meeting.sh alongside the meeting item itself.
meeting_duration=(
  drawing=off
  label.y_offset=-1.5
  label.color="$WHITE"
  padding_right=4
  padding_left=0
  y_offset=1
  click_script="$PLUGIN_DIR/meeting_click.sh"
)

sketchybar --add item meeting left \
  --set meeting "${meeting[@]}" \
  --add item meeting.duration left \
  --set meeting.duration "${meeting_duration[@]}"
