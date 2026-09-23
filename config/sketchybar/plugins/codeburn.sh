#!/bin/bash

status=$(codeburn status --format json 2>/dev/null) || {
  sketchybar --set "$NAME" label="N/A"
  exit 0
}

currency=$(jq -r '.currency // "USD"' <<<"$status")
cost=$(jq -r '.today.cost // empty' <<<"$status")

if [[ ! "$cost" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
  sketchybar --set "$NAME" label="N/A"
  exit 0
fi

if [[ "$currency" == "USD" ]]; then
  label=$(printf '$%.2f' "$cost")
else
  label=$(printf '%s %.2f' "$currency" "$cost")
fi

sketchybar --set "$NAME" label="$label"
