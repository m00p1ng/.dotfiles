#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Register custom event - this will be use by sketchy bar's space items as well as app_space.sh
ICONS_SPACE=(󰧞 󰧞 󰧞 󰧞 󰧞 󰧞 󰧞 󰧞 󰧞 󰧞)

# Space items
LENGTH=${#ICONS_SPACE[@]}

for i in "${!ICONS_SPACE[@]}"
do
  sid=$((i+1))
  PAD_LEFT=1
  PAD_RIGHT=1
  if [[ $i == 0 ]]; then
    PAD_LEFT=8
  elif [[ $i == $((LENGTH-1)) ]]; then
    PAD_RIGHT=8
  fi

  space=(
    script="$PLUGIN_DIR/app_space.sh"
    associated_space="$sid"
    padding_left="$PAD_LEFT"
    padding_right="$PAD_RIGHT"
    icon="${ICONS_SPACE[i]}"
    icon.color="$GREY"
    icon.highlight_color="$MAGENTA"
    icon.width=12
  )
  sketchybar --add space space.$sid left          \
             --set       space.$sid "${space[@]}" \
             --subscribe space.$sid front_app_switched window_change
done

# Space bracket
space_bracket=(
  background.color="$BACKGROUND_2"
  blur_radius=30
  shadow=on
  background.border_color="$WHITE"
  background.border_width=0
  icon.highlight_color="$BACKGROUND_2"
  icon.padding_left=6
  icon.padding_right=2
)
sketchybar --add bracket spaces '/space\..*/' \
           --set         spaces "${space_bracket[@]}"
