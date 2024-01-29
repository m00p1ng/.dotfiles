#!/bin/bash

source "$CONFIG_DIR/colors.sh"

STATUS_LABEL=$(lsappinfo info -only StatusLabel "Slack")
ICON="󰒱"
if [[ $STATUS_LABEL =~ \"label\"=\"([^\"]*)\" ]]; then
    LABEL="${BASH_REMATCH[1]}"
    LABEL_DRAWING=on

    if [[ $LABEL == "" ]]; then
        ICON_COLOR="$GREY"
        LABEL_DRAWING=off
    elif [[ $LABEL == "•" ]]; then
        ICON_COLOR="$YELLOW"
    elif [[ $LABEL =~ ^[0-9]+$ ]]; then
        ICON_COLOR="$RED"
    else
        exit 0
    fi
else
  ICON_COLOR="$GREY"
  LABEL_DRAWING=off
fi

slack=(
  icon="$ICON"
  label="$LABEL"
  label.drawing="$LABEL_DRAWING"
  icon.color="$ICON_COLOR"
)
sketchybar --set "$NAME" "${slack[@]}"
