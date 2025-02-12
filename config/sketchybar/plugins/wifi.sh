#!/bin/bash

update() {
  source "$CONFIG_DIR/icons.sh"
  source "$CONFIG_DIR/colors.sh"
  INFO="$(ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}')"
  LABEL="$INFO ($(ipconfig getifaddr en0))"
  ICON="$([ -n "$INFO" ] && echo "$WIFI_CONNECTED" || echo "$WIFI_DISCONNECTED")"
  COLOR="$([ -n "$INFO" ] && echo "$BLUE" || echo "$RED")"

  wifi=(
    icon="$ICON"
    icon.color="$COLOR"
    label="$LABEL"
  )
  sketchybar --set "$NAME" "${wifi[@]}"
}

click() {
  CURRENT_WIDTH="$(sketchybar --query "$NAME" | jq -r .label.width)"

  WIDTH=0
  if [ "$CURRENT_WIDTH" -eq "0" ]; then
    WIDTH=dynamic
  fi

  sketchybar --animate sin 20 --set "$NAME" label.width="$WIDTH"
}

case "$SENDER" in
"wifi_change") update ;;
"mouse.clicked") click ;;
esac
