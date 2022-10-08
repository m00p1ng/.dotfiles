main () {
  echo $(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep 'KeyboardLayout Name' | awk '{print $4}' | tr -d ';')
}

main
