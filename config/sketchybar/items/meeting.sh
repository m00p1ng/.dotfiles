#!/bin/bash

meeting=(
  label.y_offset=-1.5
  padding_right=4
  padding_left=4
  y_offset=1
  script="$PLUGIN_DIR/meeting.sh"
  update_freq=1
  updates=on
)

# meeting_duration=(
#   label.width=0
#   label.y_offset=-1.5
#   label.color="$WHITE"
#   padding_right=10
#   padding_left=0
#   y_offset=1
# )

# sketchybar --add item meeting.duration right \
#            --set meeting.duration "${meeting_duration[@]}"

sketchybar --add item meeting right \
           --set meeting "${meeting[@]}"
