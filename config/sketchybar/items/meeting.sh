#!/bin/bash

meeting=(
  label.y_offset=-1.5
  label.padding_right=0
  padding_right=0
  padding_left=4
  y_offset=1
  script="$PLUGIN_DIR/meeting.sh"
  click_script="$PLUGIN_DIR/meeting_click.sh"
  update_freq=1
  updates=on
)

# Label is filled in by plugins/meeting.sh alongside the meeting item itself.
meeting_duration=(
  drawing=off
  label.y_offset=-1.5
  label.color="$WHITE"
  label.padding_left=0
  padding_right=4
  padding_left=0
  y_offset=1
  click_script="$PLUGIN_DIR/meeting_click.sh"
)

if ((${NOTCH_WIDTH:-0} > 0)); then
  # "q" is the region hugging the left edge of the notch. It fills right-to-left,
  # so the duration is added first to end up on the right of the meeting.
  sketchybar --add item meeting.duration q \
    --set meeting.duration "${meeting_duration[@]}" \
    --add item meeting q \
    --set meeting "${meeting[@]}"
else
  # No notch to hug, so sit in the middle of the bar instead.
  sketchybar --add item meeting center \
    --set meeting "${meeting[@]}" \
    --add item meeting.duration center \
    --set meeting.duration "${meeting_duration[@]}"
fi
