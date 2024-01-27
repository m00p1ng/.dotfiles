#!/bin/bash

source "$CONFIG_DIR/icons.sh"
LENGTH=$(yabai -m query --spaces --display | jq '. | length')

ICON="󰧞"
if [[ "$SELECTED" == "true" ]]
then
 ICON=""
fi

PAD_RIGHT=1
if [[ "$SID" == "$LENGTH" ]]
then
 PAD_RIGHT=8
fi

space=(
  icon="$ICON"
	icon.highlight="$SELECTED"
  padding_right="$PAD_RIGHT"
)

sketchybar --set "$NAME" "${space[@]}"
