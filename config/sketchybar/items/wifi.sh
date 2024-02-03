#!/bin/bash

wifi=(
  padding_right=3
  label.width=0
  icon="$WIFI_DISCONNECTED"
  icon.font.size=14
  icon.color="$BLUE"
  icon.y_offset=1
  script="$PLUGIN_DIR/wifi.sh"
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}" \
           --subscribe wifi wifi_change mouse.clicked
