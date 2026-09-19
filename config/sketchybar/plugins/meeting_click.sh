#!/bin/bash
# Toggles the meeting popup, rebuilding its rows right before it is shown.

PARENT=meeting

if [[ "$(sketchybar --query "$PARENT" | jq -r '.popup.drawing')" == "on" ]]; then
  sketchybar --set "$PARENT" popup.drawing=off
else
  "$CONFIG_DIR/plugins/meeting_popup.sh"
  sketchybar --set "$PARENT" popup.drawing=on
fi
