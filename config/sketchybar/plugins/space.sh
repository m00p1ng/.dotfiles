#!/bin/bash

source "$CONFIG_DIR/icons.sh"

ICON="󰧞"
if [[ "$SELECTED" == "true" ]]
then
 ICON=""
fi

space=(
  icon="$ICON"
	icon.highlight="$SELECTED"
)

sketchybar --set "$NAME" "${space[@]}"
