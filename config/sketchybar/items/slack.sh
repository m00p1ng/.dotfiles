#!/bin/bash

slack=(
  icon="$SLACK"
  background.color="$BACKGROUND_2"
  padding_left=8
  padding_right=8
  background.padding_left=8
  background.padding_right=8
  blur_radius=30
  update_freq=10
  script="$PLUGIN_DIR/slack.sh"
  click_script="open -a Slack"
)
sketchybar  --add item slack right \
            --set slack "${slack[@]}" \
            --subscribe slack system_woke
