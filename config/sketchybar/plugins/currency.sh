#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

CACHED_PATH=$HOME/.cache/exchange-api.json
EXCHANGE_API=https://open.er-api.com/v6/latest/USD

call_exchange_api () {
  curl $EXCHANGE_API > "$CACHED_PATH"
}

if [ ! -f "$CACHED_PATH" ]; then
  touch "$CACHED_PATH"
fi

next_update=$(jq .time_next_update_unix "$CACHED_PATH")

if [ "$next_update" = "" ]; then
  call_exchange_api
elif [ "$(date '+%s')" -gt "$next_update" ]; then
  call_exchange_api
fi

THB=$(jq .rates.THB "$CACHED_PATH" | awk '{printf "%.2f\n", $1}')

currency=(
  icon="$DOLLAR_SIGN"
  label="$THB"
)
sketchybar --set "$NAME" "${currency[@]}"
