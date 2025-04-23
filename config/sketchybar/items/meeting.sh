#!/bin/bash

meeting=(
  label.y_offset=-1.5
  padding_right=0
  padding_left=4
  y_offset=1
  script="$PLUGIN_DIR/meeting.sh"
  update_freq=60
  updates=on
)

sketchybar --add item meeting right \
           --set meeting "${meeting[@]}"
