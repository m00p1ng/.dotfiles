#!/bin/bash

ICONS_SPACE=(
  "$SPACE"
  "$SPACE"
  "$SPACE"
  "$SPACE"
  "$SPACE"
  "$SPACE"
  "$SPACE"
  "$SPACE"
  "$SPACE"
  "$SPACE"
)

for i in "${!ICONS_SPACE[@]}"
do
  sid=$((i+1))

  space=(
    script="$PLUGIN_DIR/space.sh"
    background.drawing=off
    associated_space="$sid"
    padding_left=1
    padding_right=1
    icon="${ICONS_SPACE[i]}"
    icon.font.size=12
    icon.color="$GREY"
    icon.highlight_color="$MAGENTA"
    icon.width=7
  )
  sketchybar --add space space.$sid left \
             --set       space.$sid "${space[@]}" \
             --subscribe space.$sid front_app_switched window_change
done

space_padding=(
  background.drawing=off
  label.drawing=off
  icon.drawing=off
  padding_left=0
  padding_right=6
)
sketchybar --add item space.padding left \
           --set space.padding "${space_padding[@]}"

# Space bracket
space_bracket=(
  background.color="$BACKGROUND"
)
sketchybar --add bracket spaces yabai '/space\..*/' \
           --set spaces "${space_bracket[@]}"
