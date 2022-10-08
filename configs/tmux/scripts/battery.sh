main () {
  echo $(pmset -g batt | tail -1 | awk '{print $3}' | tr -d ';')
}

main
