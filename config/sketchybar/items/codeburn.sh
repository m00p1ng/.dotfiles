#!/bin/bash

codeburn=(
  icon="$FLAME"
  icon.color="$RED"
  label.y_offset=-1.5
  padding_right=0
  padding_left=4
  y_offset=1
  script="$PLUGIN_DIR/codeburn.sh"
  update_freq=60
  updates=on
  click_script="$PLUGIN_DIR/codeburn.sh"
)

sketchybar --add item codeburn right \
  --set codeburn "${codeburn[@]}" \
  --subscribe codeburn mouse.clicked
