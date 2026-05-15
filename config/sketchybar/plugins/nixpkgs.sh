#!/bin/bash

source "$CONFIG_DIR/colors.sh"

CACHE_DIR="$HOME/.cache/sketchybar"
CACHE_FILE="$CACHE_DIR/nixpkgs-revision"
REMOTE_CACHE="$CACHE_DIR/nixpkgs-remote"
ONE_HOUR=3600

fetch_remote() {
  local hash
  hash=$(git ls-remote https://github.com/NixOS/nixpkgs.git nixos-unstable 2>/dev/null | cut -c 1-7)
  if [ -n "$hash" ]; then
    echo "$hash" >"$REMOTE_CACHE"
  fi
}

if [ ! -f "$REMOTE_CACHE" ]; then
  fetch_remote
elif [ "$(($(date +%s) - $(stat -f %m "$REMOTE_CACHE")))" -ge "$ONE_HOUR" ]; then
  fetch_remote
fi

REMOTE_HASH=$(cat "$REMOTE_CACHE" 2>/dev/null)

if [ -z "$REMOTE_HASH" ]; then
  exit 0
fi

if [ ! -f "$CACHE_FILE" ]; then
  echo "$REMOTE_HASH" >"$CACHE_FILE"
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

CACHED_HASH=$(cat "$CACHE_FILE")

if [ "$SENDER" = "mouse.clicked" ]; then
  echo "$REMOTE_HASH" >"$CACHE_FILE"
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

if [ "$REMOTE_HASH" != "$CACHED_HASH" ]; then
  sketchybar --set "$NAME" drawing=on label="New!" label.color="$GREEN"
else
  sketchybar --set "$NAME" drawing=off
fi
