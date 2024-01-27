#!/bin/bash

volume=(
  padding_left=0
  padding_right=0
  icon.padding_left=0
  icon.padding_right=0
  label.padding_left=0
  label.padding_right=0
  background.padding_left=-4
  background.padding_right=-10
  script="$PLUGIN_DIR/volume.sh"
)

ALIAS_NAME="Control Center,Sound"

sketchybar --add alias "$ALIAS_NAME" right    \
           --set "$ALIAS_NAME" "${volume[@]}" \
           --subscribe "$ALIAS_NAME" volume_change
