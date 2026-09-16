#!/bin/bash
# https://github.com/omerxx/dotfiles/blob/master/tmux/scripts/cal.sh

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"
# PLUGIN_DIR is not exported to spawned scripts; only CONFIG_DIR is.
source "$CONFIG_DIR/plugins/meeting_query.sh"

LIMIT_TITLE=50

ICON="$CALENDAR"
ICON_COLOR=$RED
DRAWING=on

# icalBuddy prints the event as two lines: "HH:MM - HH:MM" then an indented title.
parse_result() {
  start_time=$(echo "$1" | sed -n '1s/^\([0-9][0-9]:[0-9][0-9]\).*/\1/p')
  title=$(echo "$1" | sed -n '2s/^[[:space:]]*//p')
}

minutes_until() {
  local epoc_now epoc_target
  epoc_now=$(/bin/date +%s)
  epoc_target=$(/bin/date -j -f "%T" "${1:-00:00}:00" +%s)
  echo $(((epoc_target - epoc_now) / 60 + 1))
}

get_title() {
  if [[ ${#title} -gt $LIMIT_TITLE ]]; then
    echo "${title:0:$LIMIT_TITLE}..."
  else
    echo "$title"
  fi
}

parse_result "$(meeting_query "title,datetime" "datetime,title")"

if [[ -z "$title" ]]; then
  DRAWING=off
  ICON="$CALENDAR_FREE"
else
  LABEL="$start_time $(get_title)"
  if (($(minutes_until "$start_time") >= 1)); then
    ICON_COLOR=$BLUE
  else
    ICON="$CALENDAR_BUSY"
    ICON_COLOR=$ORANGE
  fi
fi

meeting=(
  drawing="$DRAWING"
  icon="$ICON"
  icon.color="$ICON_COLOR"
  label="$LABEL"
)

sketchybar --set "$NAME" "${meeting[@]}"
