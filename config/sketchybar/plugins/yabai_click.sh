#!/bin/bash

source "$CONFIG_DIR/icons.sh"

mode=$(yabai -m query --spaces --display | jq -r 'map(select(."has-focus" == true))[-1].type')

NEXT_MODE=bsp
ICON="$YABAI_GRID"

# case "$mode" in
#   bsp)
#     NEXT_MODE=stack
#     ICON="$YABAI_STACK"
#   ;;
#   stack)
#     NEXT_MODE=float
#     ICON="$YABAI_FLOAT"
#   ;;
#   float)
#     NEXT_MODE=bsp
#     ICON="$YABAI_GRID"
#   ;;
# esac

case "$mode" in
  bsp)
    NEXT_MODE=float
    ICON="$YABAI_FLOAT"
  ;;
  stack | float)
    NEXT_MODE=bsp
    ICON="$YABAI_GRID"
  ;;
esac

yabai -m space --layout "$NEXT_MODE" && sketchybar -m --set yabai icon="$ICON"
