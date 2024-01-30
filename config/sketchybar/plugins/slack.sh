#!/bin/bash

source "$CONFIG_DIR/colors.sh"

STATUS_LABEL=$(lsappinfo info -only StatusLabel "Slack")
if [[ $STATUS_LABEL =~ \"label\"=\"([^\"]*)\" ]]; then
    LABEL="${BASH_REMATCH[1]}"
    LABEL_DRAWING=on
    ICON_PADDING_LEFT=7
    ICON_PADDING_RIGHT=7
    LABEL_PADDING_LEFT=4
    LABEL_PADDING_RIGHT=7

    if [[ $LABEL == "" ]]; then
        ICON_COLOR="$GREY"
        LABEL_DRAWING=off
    elif [[ $LABEL == "•" ]]; then
        ICON_COLOR="$YELLOW"
        ICON_PADDING_RIGHT=0
    elif [[ $LABEL =~ ^[0-9]+$ ]]; then
        ICON_COLOR="$RED"
        ICON_PADDING_RIGHT=0
    else
        exit 0
    fi
else
  ICON_COLOR="$GREY"
  LABEL_DRAWING=off
fi

slack=(
  icon.color="$ICON_COLOR"
  icon.padding_left="$ICON_PADDING_LEFT"
  icon.padding_right="$ICON_PADDING_RIGHT"
  label="$LABEL"
  label.drawing="$LABEL_DRAWING"
  label.padding_left="$LABEL_PADDING_LEFT"
  label.padding_right="$LABEL_PADDING_RIGHT"
)
sketchybar --set "$NAME" "${slack[@]}"
