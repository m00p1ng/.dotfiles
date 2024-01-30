#!/bin/bash

source "$CONFIG_DIR/icons.sh"

mode=$(yabai -m query --spaces --display | jq -r 'map(select(."has-focus" == true))[-1].type')

ICON=""
case "$mode" in
  bsp)   ICON="$YABAI_GRID"  ;;
  stack) ICON="$YABAI_STACK" ;;
  float) ICON="$YABAI_FLOAT" ;;
esac

yabai=(
 icon="$ICON"
)
sketchybar -m --set yabai "${yabai[@]}"
