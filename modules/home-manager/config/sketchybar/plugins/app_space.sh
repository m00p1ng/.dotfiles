#!/bin/bash

source "$CONFIG_DIR/icons.sh"

space=(
  background.drawing="false"
	icon.highlight="$SELECTED"
)
sketchybar --set "$NAME" "${space[@]}"

ICON="󰧞"
if [[ "$SELECTED" == "true" ]]
then
 ICON=""
fi

sketchybar --set "$NAME" icon="$ICON"
