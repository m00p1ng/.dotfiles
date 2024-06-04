#!/bin/bash

slack=(
  icon="$SLACK"
  background.color="$TRANSPARENT"
  padding_left=8
  padding_right=8
  background.padding_left=8
  background.padding_right=8
  update_freq=10
  script="$PLUGIN_DIR/slack.sh"
  click_script="open -a Slack"
)
sketchybar --add item slack right \
  --set slack "${slack[@]}" \
  --subscribe slack system_woke
