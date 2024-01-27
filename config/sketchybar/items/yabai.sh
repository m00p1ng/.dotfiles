yabai=(
  update_freq=3
  icon.font="$ICON_FONT:Regular:14.0"
  icon.padding_left=7
  label.drawing=off
  script="$PLUGIN_DIR/yabai.sh"
  click_script="$PLUGIN_DIR/yabai_click.sh"
)

sketchybar -m --add item yabai left \
              --set yabai "${yabai[@]}" \
              --subscribe yabai mouse.clicked window_focus space_change
