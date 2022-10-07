FG="#626262"
BG="#111111"
TC="#6A9955"
# SC="#E8AB53"
SC="#264F78"
AP="#D16969"
AT="#363636"
TX="#CCCCCC"

make_bubble () {
  prefix="#[fg=$AT,bg=$BG]#[fg=#$TX,bg=$AT]"
  suffix="#[fg=$AT,bg=$BG]"
  echo "$prefix$1$suffix"
}

calendar_widget () {
  icon="#[fg=#$AP,bg=$AT]#[fg=#$TX,bg=$AT]"
  format="%a %-d %H:%M"
  make_bubble "$icon $format"
}

battery_widget () {
  heart="#[fg=#$AP,bg=$AT]♥#[fg=#$TX,bg=$AT]"
  battery="#(pmset -g batt | tail -1 | awk '{print \$3}' | tr -d ';')"
  make_bubble "$heart $battery"
}

set_right_status_theme () {
  battery=$(battery_widget)
  calendar=$(calendar_widget)

  status_right="$battery $calendar "

  tmux set -g status-right-length 150
  tmux set -g status-right "$status_right"
}

set_left_status_theme () {
  tmux set -g status-left-length 150
  tmux set -g status-left "#[fg=$BG,bg=$TC,bold]  #S#[fg=$TC,bg=$BG] "
}

set_window_status_theme () {
  zoom_prefix="#{?window_zoomed_flag,,}"
  zoom_suffix="#{?window_zoomed_flag,*,}"
  status="  #I $zoom_prefix#W$zoom_suffix  "
  tmux setw -g window-status-format "$status"

  current_zoom_prefix="#{?window_zoomed_flag,#[fg=#$AP],#[fg=#$TX]}"
  current_zoom_suffix="#{?window_zoomed_flag,*,}"
  current_status=$(make_bubble " #I $current_zoom_prefix#W$current_zoom_suffix ")
  tmux setw -g window-status-current-format "$current_status"
}

set_theme () {
  # Status bar
  tmux set -g status-fg "$FG"
  tmux set -g status-bg "$BG"
  set_right_status_theme
  set_left_status_theme
  set_window_status_theme

  # Others
  tmux set -g window-status-separator      ""               # Window separator
  tmux set -g window-status-current-style  "fg=$TC,bg=$BG"  # Current window status

  tmux set -g status-justify               left             # Window status alignment
  tmux set -g pane-border-style            "fg=#444444"     # Pane border
  tmux set -g pane-active-border-style     "fg=$TC"         # Active pane border
  # tmux set -g display-panes-colour         "#444444"        # Pane number indicator
  # tmux set -g display-panes-active-colour  "#777777"        # Active pane number indicator
  tmux set -g clock-mode-colour            "$TC"            # Clock mode
  tmux set -g message-style                "fg=$TC,bg=$BG"  # Message
  tmux set -g message-command-style        "fg=$TC,bg=$BG"  # Command message
  tmux set -g mode-style                   "fg=$TX,bg=$SC"  # Copy mode highlight
}

set_theme
