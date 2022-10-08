CONNECT_ICON=""
DISCONNECT_ICON=""

main () {
  result=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep -o 'SSID: .\+')

  if [ "$result" = "" ]; then
    echo "$DISCONNECT_ICON"
  else
    echo "$CONNECT_ICON"
  fi
}

main
