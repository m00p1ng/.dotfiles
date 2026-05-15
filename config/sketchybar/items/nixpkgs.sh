#!/bin/bash

nixpkgs=(
  icon="󱄅"
  icon.color="$BLUE"
  icon.font.size=20
  drawing=off
  update_freq=10
  updates=on
  script="$PLUGIN_DIR/nixpkgs.sh"
  click_script="$PLUGIN_DIR/nixpkgs.sh"
)

sketchybar --add item nixpkgs right \
  --set nixpkgs "${nixpkgs[@]}" \
  --subscribe nixpkgs mouse.clicked
