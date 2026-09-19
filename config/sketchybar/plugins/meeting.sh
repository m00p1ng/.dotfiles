#!/bin/bash
# https://github.com/omerxx/dotfiles/blob/master/tmux/scripts/cal.sh

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/meeting_query.sh"

# The pointer left the bar, so the popup is no longer wanted.
if [[ "$SENDER" == "mouse.exited.global" ]]; then
  sketchybar --set "$NAME" popup.drawing=off
  exit 0
fi

LIMIT_TITLE=50

ICON="$CALENDAR"
ICON_COLOR=$RED
DRAWING=on

# ical-guy returns a JSON event with ISO 8601 timestamps.
parse_result() {
  title=$(jq -r '.title // ""' <<<"$1")
  start_time=$(format_time "$(jq -r '.startDate // empty' <<<"$1")")
  end_time=$(format_time "$(jq -r '.endDate // empty' <<<"$1")")
}

format_time() {
  local datetime="$1" epoch

  [[ -z "$datetime" ]] && return

  # DateFormatter may include fractional seconds; BSD date does not accept them.
  [[ "$datetime" == *.*Z ]] && datetime="${datetime%%.*}Z"

  # EventKit emits UTC ISO 8601 timestamps. Parse in UTC, then format locally.
  epoch=$(/bin/date -j -u -f "%Y-%m-%dT%H:%M:%SZ" "$datetime" +%s 2>/dev/null) || return
  /bin/date -r "$epoch" +%H:%M
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

parse_result "$(meeting_query)"

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

meeting_icon=(
  drawing="$DRAWING"
  icon="$ICON"
  icon.color="$ICON_COLOR"
)

meeting=(
  drawing="$DRAWING"
  label="$LABEL"
)

meeting_duration=(
  drawing="$DRAWING"
  label="$DURATION"
)

sketchybar --set "$NAME.icon" "${meeting_icon[@]}" \
  --set "$NAME" "${meeting[@]}" \
  --set "$NAME.duration" "${meeting_duration[@]}"
