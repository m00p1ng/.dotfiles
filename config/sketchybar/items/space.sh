#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

ICONS_SPACE=(󰧞 󰧞 󰧞 󰧞 󰧞 󰧞 󰧞 󰧞 󰧞 󰧞)

for i in "${!ICONS_SPACE[@]}"
do
  sid=$((i+1))
  PAD_LEFT=1
  PAD_RIGHT=1
  if [[ $i == 0 ]]; then
    PAD_LEFT=8
  fi

  space=(
    script="$PLUGIN_DIR/space.sh"
    background.drawing="false"
    associated_space="$sid"
    padding_left="$PAD_LEFT"
    padding_right="$PAD_RIGHT"
    icon="${ICONS_SPACE[i]}"
    icon.color="$GREY"
    icon.highlight_color="$MAGENTA"
    icon.width=6
  )
  sketchybar --add space space.$sid left          \
             --set       space.$sid "${space[@]}" \
             --subscribe space.$sid front_app_switched window_change
done

# Space bracket
space_bracket=(
  background.color="$BACKGROUND_2"
)
sketchybar --add bracket spaces yabai '/space\..*/' \
           --set         spaces "${space_bracket[@]}"
