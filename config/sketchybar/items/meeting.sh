#!/bin/bash

# The icon is its own item so that it can carry its own click target: the icon
# jumps straight into the meeting, the text opens the popup.
meeting_icon=(
  drawing=off
  y_offset=1
  padding_left=4
  padding_right=0
  icon.padding_right=0
  click_script="$PLUGIN_DIR/meeting_open.sh"
)

# Icon, label and duration are all filled in by plugins/meeting.sh.
meeting=(
  icon.drawing=off
  label.y_offset=-1.5
  label.padding_left=2
  label.padding_right=0
  padding_right=0
  padding_left=0
  y_offset=1
  script="$PLUGIN_DIR/meeting.sh"
  click_script="$PLUGIN_DIR/meeting_click.sh"
  update_freq=1
  updates=on
  popup.background.color="$BLACK"
  popup.background.border_width=1
  popup.background.border_color="$BAR_BORDER_COLOR"
  popup.background.corner_radius=6
  popup.background.shadow.drawing=on
  popup.align=center
  popup.y_offset=4
  popup.height=20
)

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
  # so the items are added back to front to read icon, title, duration.
  sketchybar --add item meeting.duration q \
    --set meeting.duration "${meeting_duration[@]}" \
    --add item meeting q \
    --set meeting "${meeting[@]}" \
    --add item meeting.icon q \
    --set meeting.icon "${meeting_icon[@]}"
else
  # No notch to hug, so sit in the middle of the bar instead.
  sketchybar --add item meeting.icon center \
    --set meeting.icon "${meeting_icon[@]}" \
    --add item meeting center \
    --set meeting "${meeting[@]}" \
    --add item meeting.duration center \
    --set meeting.duration "${meeting_duration[@]}"
fi

# Dismiss the popup as soon as the pointer leaves the bar, see plugins/meeting.sh.
sketchybar --subscribe meeting mouse.exited.global
