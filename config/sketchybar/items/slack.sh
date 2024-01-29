slack=(
  update_freq=180 \
  script="$PLUGIN_DIR/slack.sh" \
  icon.font.size=18 \
  icon.padding_left=8 \
  icon.padding_right=8 \
  background.color="$BACKGROUND_2"
  background.padding_left=4 \
  blur_radius=30
  click_script="open -a Slack"
)
sketchybar  --add   item slack right \
            --set   slack "${slack[@]}" \
            --subscribe slack system_woke
