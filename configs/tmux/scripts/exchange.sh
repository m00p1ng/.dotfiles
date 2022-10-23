CACHED_PATH=$HOME/.cache/exchange-api.json
EXCHANGE_API=https://open.er-api.com/v6/latest/USD

call_exchange_api () {
  curl $EXCHANGE_API > $CACHED_PATH
}

main () {
  if [ ! -f $CACHED_PATH ]; then
    touch $CACHED_PATH
  fi

  next_update=$(cat $CACHED_PATH | jq .time_next_update_unix)

  if [ "$next_update" = "" ]; then
    call_exchange_api
  elif [ "$(date '+%s')" -gt "$next_update" ]; then
    call_exchange_api
  fi

  cat $CACHED_PATH | jq .rates.THB | awk '{printf "%.2f\n", $1}'
}

main
