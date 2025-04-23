#!/bin/bash
# https://github.com/omerxx/dotfiles/blob/master/tmux/scripts/cal.sh
#
source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

LIMIT_TITLE=30
COLOR=$RED
DRAWING=on

get_next_meeting() {
  next_meeting=$(icalBuddy \
    --includeEventProps "title,datetime" \
    --propertyOrder "datetime,title" \
    --noCalendarNames \
    --dateFormat "%A" \
    --includeOnlyEventsFromNowOn \
    --limitItems 1 \
    --excludeAllDayEvents \
    --separateByDate \
    --bullet "" \
    eventsToday)
}

parse_result() {
  array=()
  for line in $1; do
    array+=("$line")
  done
  time="${array[2]}"
  title="${array[*]:5:30}"
}

calculate_times() {
  epoc_meeting=$(/bin/date -j -f "%T" "${time:-00:00}:00" +%s)
  epoc_now=$(/bin/date +%s)
  epoc_diff=$((epoc_meeting - epoc_now))
  minutes_till_meeting=$((epoc_diff / 60))
}

parse_time() {
  abs_mins=$((minutes_till_meeting > 0 ? minutes_till_meeting : -minutes_till_meeting))
  hours=$((abs_mins / 60))
  minutes=$((abs_mins % 60))

  if [[ $minutes_till_meeting -lt 0 ]]; then
    echo "(Now!)"
    return
  fi

  res=""
  if [[ $hours -gt 0 ]]; then
    res="$res${hours}h"
  fi

  echo "($res${minutes}m)"
}

parse_title() {
  res=""
  if [[ ${#title} -gt $LIMIT_TITLE ]]; then
    res="$res${title:0:$LIMIT_TITLE}..."
  else
    res="$res$title"
  fi

  echo "$res"
}

print_meeting_title() {
  if [[ "$title" != "" ]]; then
    echo "$time $(parse_title) $(parse_time)"
  else
    echo "-"
  fi
}

print_meeting_icon() {
  if [[ $title == "" ]]; then
    COLOR=$GREEN
    echo "$CALENDAR_FREE"
    return
  fi

  if [[ $epoc_diff -gt 0 ]]; then
    echo "$CALENDAR"
    DRAWING=off
    return
  fi

  COLOR=$ORANGE
  echo "$CALENDAR_BUSY"
}

get_next_meeting
parse_result "$next_meeting"
calculate_times

LABEL=$(print_meeting_title)
ICON=$(print_meeting_icon)

meeting=(
  icon="$ICON"
  icon.color="$COLOR"
  icon.drawing="$DRAWING"
  label="$LABEL"
)
sketchybar --set "$NAME" "${meeting[@]}"
