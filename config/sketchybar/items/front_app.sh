#!/bin/bash

front_app=(
  label.font="$LABEL_FONT:Regular:14.0"
  label.y_offset=2
  label.padding_right=10
  icon.background.drawing=on
  display=active
  label.color="$WHITE"
  background.padding_left=4
  background.color="$BACKGROUND_2"
  background.border_color="$BACKGROUND_2"
  blur_radius=15
  icon.drawing=on
  icon.background.image.scale=0.9
  icon.background.image.padding_left=2
  script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
