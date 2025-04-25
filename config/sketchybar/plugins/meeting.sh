#!/bin/bash
# https://github.com/omerxx/dotfiles/blob/master/tmux/scripts/cal.sh
#
source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

LIMIT_TITLE=30

ICON="$CALENDAR"
ICON_COLOR=$RED
DRAWING=on

get_next_meeting() {
  icalBuddy \
    --includeEventProps "title,datetime" \
    --propertyOrder "datetime,title" \
    --noCalendarNames \
    --dateFormat "%A" \
    --includeOnlyEventsFromNowOn \
    --limitItems 1 \
    --excludeAllDayEvents \
    --separateByDate \
    --bullet "" \
    eventsToday
}

parse_result() {
  local array=()
  for line in $1; do
    array+=("$line")
  done
  start_time="${array[2]}"
  end_time="${array[4]}"
  title="${array[*]:5:30}"
}

calculate_times() {
  epoc_now=$(/bin/date +%s)

  epoc_meeting=$(/bin/date -j -f "%T" "${start_time:-00:00}:00" +%s)
  epoc_diff=$((epoc_meeting - epoc_now))
  minutes_till_meeting=$((epoc_diff / 60 + 1))

  epoc_end_meeting=$(/bin/date -j -f "%T" "${end_time:-00:00}:00" +%s)
  epoc_end_diff=$((epoc_end_meeting - epoc_now))
  minutes_till_end_meeting=$((epoc_end_diff / 60 + 1))
}

get_duration() {
  abs_mins=$((minutes_till_meeting > 0 ? minutes_till_meeting : minutes_till_end_meeting))
  hours=$((abs_mins / 60))
  minutes=$((abs_mins % 60))

  res=""
  if [[ $hours -gt 0 ]]; then
    res="$res${hours}h"
  fi

  if [[ $minutes -gt 0 ]]; then
    res="$res${minutes}m"
  fi

  if [[ "$title" != "" ]] && [[ $minutes_till_end_meeting -ge 1 ]]; then
    res="$res left"
  fi

  echo "($res)"
}

get_title() {
  if [[ ${#title} -gt $LIMIT_TITLE ]]; then
    echo "${title:0:$LIMIT_TITLE}..."
  else
    echo "$title"
  fi
}

parse_result "$(get_next_meeting)"
calculate_times

if [[ "$title" != "" ]]; then
  LABEL="$start_time $(get_title)"
else
  DRAWING=off
fi

if [[ "$title" == "" ]]; then
  ICON="$CALENDAR_FREE"
elif [[ $minutes_till_meeting -ge 1 ]]; then
  ICON_COLOR=$BLUE
else
  ICON="$CALENDAR_BUSY"
  ICON_COLOR=$ORANGE
fi

meeting=(
  drawing="$DRAWING"
  icon="$ICON"
  icon.color="$ICON_COLOR"
  label="$LABEL"
)

meeting_duration=(
  drawing="$DRAWING"
  label="$(get_duration)"
)

sketchybar --set "$NAME" "${meeting[@]}"
sketchybar --set "$NAME.duration" "${meeting_duration[@]}"
