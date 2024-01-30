#!/bin/bash

source "$CONFIG_DIR/icons.sh"

ICON="$SPACE"
if [[ "$SELECTED" == "true" ]]
then
 ICON="$SPACE_SELECTED"
fi

space=(
  icon="$ICON"
	icon.highlight="$SELECTED"
)

sketchybar --set "$NAME" "${space[@]}"
