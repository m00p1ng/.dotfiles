CONNECT_ICON="直"
DISCONNECT_ICON="睊"

main () {
  result=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep -o 'SSID: .\+')

  if [ "$result" = "" ]; then
    echo "$DISCONNECT_ICON"
  else
    echo "$CONNECT_ICON"
  fi
}

main
