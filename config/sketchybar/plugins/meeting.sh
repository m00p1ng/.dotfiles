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
# end_time stays empty for multi-day events, whose end reads "...".
parse_result() {
  start_time=$(echo "$1" | sed -n '1s/^\([0-9][0-9]:[0-9][0-9]\).*/\1/p')
  end_time=$(echo "$1" | sed -n '1s/^[0-9][0-9]:[0-9][0-9] - \([0-9][0-9]:[0-9][0-9]\).*/\1/p')
  title=$(echo "$1" | sed -n '2s/^[[:space:]]*//p')
}

minutes_until() {
  local epoc_now epoc_target
  epoc_now=$(/bin/date +%s)
  epoc_target=$(/bin/date -j -f "%T" "${1:-00:00}:00" +%s)
  echo $(((epoc_target - epoc_now) / 60 + 1))
}

# 62 -> "(1h 2m)", 60 -> "(1h)", 2 -> "(2m)"
format_duration() {
  local total=$1 hours minutes res=""

  ((total < 0)) && total=0
  hours=$((total / 60))
  minutes=$((total % 60))

  ((hours > 0)) && res="${hours}h"
  if ((minutes > 0)); then
    res="${res:+$res }${minutes}m"
  fi

  echo "(${res:-0m})"
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
  minutes_till_start=$(minutes_until "$start_time")

  if ((minutes_till_start >= 1)); then
    # Not started yet: count down to the start.
    ICON_COLOR=$BLUE
    DURATION=$(format_duration "$minutes_till_start")
  else
    # In progress: count down the time left, when we know the end.
    ICON="$CALENDAR_BUSY"
    ICON_COLOR=$ORANGE
    [[ -n "$end_time" ]] && DURATION=$(format_duration "$(minutes_until "$end_time")")
  fi
fi

meeting=(
  drawing="$DRAWING"
  icon="$ICON"
  icon.color="$ICON_COLOR"
  label="$LABEL"
)

meeting_duration=(
  drawing="$DRAWING"
  label="$DURATION"
)

sketchybar --set "$NAME" "${meeting[@]}" \
  --set "$NAME.duration" "${meeting_duration[@]}"
