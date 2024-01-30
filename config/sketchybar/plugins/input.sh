#!/bin/bash

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID | cut -d. -f4)

input=(
  label="$SOURCE"
)
sketchybar --set "$NAME" "${input[@]}"
