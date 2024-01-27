#!/bin/bash

currency=(
  script="$PLUGIN_DIR/currency.sh"
  icon.font="$ICON_FONT:Regular:18.0"
  label.font="$LABEL_FONT:Regular:12.0"
  icon.color="$ORANGE"
  padding_right=0
  padding_left=4
  label.y_offset=-1.5
  y_offset=1
  label.drawing=on
  update_freq=3600
  updates=on
)

sketchybar --add item currency right      \
           --set currency "${currency[@]}"
