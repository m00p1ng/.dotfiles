function wifi --description "connect wifi (macOS)"
  set ssid (
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s \
    | sed 1d \
    | awk '{print $1}' \
    | sort \
    | uniq \
    | fzf \
  )

  if [ "x$ssid" != "x" ]
    networksetup -setairportnetwork en0 $ssid
  end
end
