#!/bin/bash

source "$CONFIG_DIR/colors.sh"

COLOR=$WHITE

volume_change() {
  case $INFO in
    0) COLOR=$GREY ;;
    *) COLOR=$YELLOW ;;
  esac

  sketchybar --set "$NAME" alias.color="$COLOR"
}

case "$SENDER" in
  "volume_change") volume_change ;;
esac
