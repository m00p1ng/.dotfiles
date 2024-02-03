#!/bin/bash

source "$CONFIG_DIR/colors.sh"

COLOR=$WHITE

volume_change() {
  case $INFO in
    0) COLOR=$GREY ;;
    *) COLOR=$MAGENTA ;;
  esac

  volume=(
    alias.color="$COLOR"
  )
  sketchybar --set "$NAME" "${volume[@]}"
}

case "$SENDER" in
  "volume_change") volume_change ;;
esac
