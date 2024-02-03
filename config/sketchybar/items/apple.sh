#!/bin/bash

apple_logo=(
  background.color="$BACKGROUND_1"
  icon="$APPLE"
  icon.font.size=16
  icon.color="$WHITE"
  icon.padding_right=15
  icon.padding_left=15
  label.drawing=off
)

sketchybar --add item apple.logo left                  \
           --set apple.logo "${apple_logo[@]}"
