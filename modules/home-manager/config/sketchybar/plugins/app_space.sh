#!/bin/bash

source "$HOME/.config/sketchybar/icons.sh"

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item
space=(
  background.drawing="false"
	icon.highlight="$SELECTED"
)
sketchybar --set "$NAME" "${space[@]}"

if [[ $SENDER == "front_app_switched" || $SENDER == "window_change" ]];
then
   ICON="󰧞"
   if [[ "$SELECTED" == "true" ]]
   then
     ICON=""
   fi

   sketchybar --set "$NAME" icon="$ICON"
fi
