main () {
  result=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep -o 'SSID: .\+')

  if [ "$result" = "" ]; then
    echo '[Offline]'
  else
    echo $result | cut -d: -f2 | awk '{gsub(/^ /, ""); print}'
  fi
}

main
