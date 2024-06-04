#!/bin/bash

front_app=(
  label.color="$WHITE"
  label.font.size=14.0
  label.y_offset=2
  label.padding_right=10
  icon.background.drawing=on
  icon.background.image.scale=0.9
  icon.background.image.padding_left=2
  background.color="$TRANSPARENT"
  background.border_color="$TRANSPARENT"
  background.padding_left=4
  display=active
  script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched
