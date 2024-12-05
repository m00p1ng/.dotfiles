#!/bin/bash

currency=(
  icon="$DOLLAR_SIGN"
  icon.color="$ORANGE"
  label.y_offset=-1.5
  padding_right=0
  padding_left=4
  y_offset=1
  script="$PLUGIN_DIR/currency.sh"
  update_freq=3600
  updates=on
  click_script="$PLUGIN_DIR/currency.sh"
)

sketchybar --add item currency right \
           --set currency "${currency[@]}" \
           --subscribe currency mouse.clicked wifi_change
