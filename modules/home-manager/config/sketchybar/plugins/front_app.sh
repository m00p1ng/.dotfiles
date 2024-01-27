#!/bin/bash

if [ "$SENDER" = "front_app_switched" ]; then
  args=(label="$INFO")
  case $INFO in
    "SecurityAgent" | "coreautha")
      ;;
    *)
      args+=(icon.background.image="app.$INFO")
      ;;
  esac

  sketchybar --set "$NAME" "${args[@]}"
fi
