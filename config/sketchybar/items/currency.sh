#!/bin/bash

currency=(
  icon="$DOLLAR_SIGN"
  icon.font="$ICON_FONT:Regular:18.0"
  icon.color="$ORANGE"
  label.font="$LABEL_FONT:Regular:12.0"
  label.drawing=on
  label.y_offset=-1.5
  padding_right=0
  padding_left=4
  y_offset=1
  script="$PLUGIN_DIR/currency.sh"
  update_freq=3600
  updates=on
)

sketchybar --add item currency right \
           --set currency "${currency[@]}"
