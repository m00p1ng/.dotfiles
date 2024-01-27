#!/bin/bash

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID | cut -d. -f4)

sketchybar --set "$NAME" label="$SOURCE"
