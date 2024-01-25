#!/bin/bash

volume_icon=(
  padding_left=0
  padding_right=0
  icon.padding_left=0
  icon.padding_right=0
  label.padding_left=0
  label.padding_right=0
  background.padding_left=-4
  background.padding_right=-10
  alias.color="$WHITE"
)

sketchybar --add alias "Control Center,Sound" right         \
           --set "Control Center,Sound" "${volume_icon[@]}"
