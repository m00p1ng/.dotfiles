#!/bin/bash

source "$CONFIG_DIR/icons.sh"

mode=$(yabai -m query --spaces --display | jq -r 'map(select(."has-focus" == true))[-1].type')

if [ "$SENDER" = "mouse.clicked" ]; then
  NEXT_MODE=bsp
  ICON="$YABAI_GRID"

  case "$mode" in
    bsp)
      NEXT_MODE=float
      ICON="$YABAI_FLOAT"
      ;;
    stack)
      NEXT_MODE=bsp
      ICON="$YABAI_FLOAT"
      ;;
    float)
      NEXT_MODE=bsp
      ICON="$YABAI_GRID"
      ;;
  esac

  yabai -m space --layout "$NEXT_MODE" && sketchybar -m --set yabai icon="$ICON"
  exit
fi

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
