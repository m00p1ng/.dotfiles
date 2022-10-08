BATTERY_0=" "
BATTERY_1=" "
BATTERY_2=" "
BATTERY_3=" "
BATTERY_4=" "

main () {
  result=$(pmset -g batt | tail -1 | awk '{print $3}' | tr -d '%;')

  if [ $result -ge 85 ]; then
    echo "$BATTERY_4"
  elif [ $result -ge 60 ]; then
    echo "$BATTERY_3"
  elif [ $result -ge 30 ]; then
    echo "$BATTERY_2"
  elif [ $result -ge 10 ]; then
    echo "$BATTERY_1"
  else
    echo "$BATTERY_0"
  fi
}

main
