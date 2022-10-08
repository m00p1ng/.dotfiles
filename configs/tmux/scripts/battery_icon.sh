charging_icon=""
discharging_icon=""
main () {
  result=$(pmset -g batt | tail -1 | grep -o 'discharging')

  if [ "$result" = "" ]; then
    echo "$charging_icon"
  else
    echo "$discharging_icon"
  fi
}

main
