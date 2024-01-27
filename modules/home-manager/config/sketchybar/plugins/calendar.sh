#!/bin/bash

source "$CONFIG_DIR/icons.sh"

sketchybar --set $NAME icon=$CALENDAR, label="$(date '+%a %d. %b')"
