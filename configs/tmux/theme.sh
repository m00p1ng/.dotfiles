calendar_widget () {
  format="%a %-d %H:%M"
  calendar="#[fg=#6A9955,bg=#3A3A3A]#[fg=#111111,bg=#6A9955]  $format"
  echo $calendar
}

battery_widget () {
  heart="#[fg=colour009,bg=#3A3A3A] ♥ #[fg=white,bg=#3A3A3A]"
  battery="#(pmset -g batt | tail -1 | awk '{print \$3}' | tr -d ';')"
  echo "$heart$battery"
}

set_right_status_theme () {
  status_right="#[fg=#3A3A3A,bg=#111111]"
  calendar=$(calendar_widget)
  battery=$(battery_widget)

  status_right="$status_right$battery $calendar "

  tmux set -g status-right-length 150
  tmux set -g status-right "$status_right"
}

set_left_status_theme () {
  tmux set -g status-left-length 150
  tmux set -g status-left "#[fg=#111111,bg=#6A9955,bold]  #S #[fg=#6A9955,bg=#111111,nobold] "
}

set_window_status_theme () {
  zoom_prefix="#{?window_zoomed_flag,,}"
  zoom_suffix="#{?window_zoomed_flag,*,}"
  status="  #I $zoom_prefix#W$zoom_suffix  "
  tmux setw -g window-status-format "$status"

  current_arrow_prefix="#[fg=#363636,bg=#111111]#[fg=white,bg=#363636]"
  current_arrow_suffix="#[fg=#363636,bg=#111111]"
  current_zoom_prefix="#{?window_zoomed_flag,#[fg=red],#[fg=white]}"
  current_zoom_suffix="#{?window_zoomed_flag,*,}"
  current_status=" #I $current_zoom_prefix#W$current_zoom_suffix "
  tmux setw -g window-status-current-format "$current_arrow_prefix$current_status$current_arrow_suffix"
}

set_theme () {
  # Status bar
  tmux set -g status-fg "#626262"
  tmux set -g status-bg "#111111"
  set_right_status_theme
  set_left_status_theme
  set_window_status_theme

  # Others
  tmux setw -g window-status-separator      ""                      # Window separator
  tmux setw -g window-status-current-style  "fg=#6A9955,bg=#111111" # Current window status

  tmux set  -g status-justify               left                    # Window status alignment
  tmux set  -g pane-border-style            "fg=#444444,bg=default" # Pane border
  tmux set  -g pane-active-border-style     "fg=#6A9955"            # Active pane border
  # tmux set  -g display-panes-colour         "#444444"               # Pane number indicator
  # tmux set  -g display-panes-active-colour  "#777777"               # Active pane number indicator
  tmux set  -g clock-mode-colour            "#6A9955"               # Clock mode
  tmux set  -g message-style                "fg=#6A9955,bg=#111111" # Message
  tmux set  -g message-command-style        "fg=#6A9955,bg=#111111" # Command message
  tmux set  -g mode-style                   "bg=#1D361D"            # Copy mode highlight
}

set_theme
