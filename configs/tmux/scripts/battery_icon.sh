BATTERY_0=" "
BATTERY_1=" "
BATTERY_2=" "
BATTERY_3=" "
BATTERY_4=" "
CHARGING=""

main () {
  percent=$(pmset -g batt | tail -1 | awk '{print $3}' | tr -d '%;')
  discharging=$(pmset -g batt | tail -1 | grep discharging)

  if [ "$discharging" = "" ]; then
    echo "$CHARGING"
  elif [ $percent -ge 85 ]; then
    echo "$BATTERY_4"
  elif [ $percent -ge 60 ]; then
    echo "$BATTERY_3"
  elif [ $percent -ge 30 ]; then
    echo "$BATTERY_2"
  elif [ $percent -ge 10 ]; then
    echo "$BATTERY_1"
  else
    echo "$BATTERY_0"
  fi
}

main
