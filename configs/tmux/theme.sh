set_status_right_theme () {
  status_right="#[fg=#3A3A3A,bg=#262626]"
  heart="#[fg=colour009,bg=#3A3A3A] ♥ #[fg=white,bg=#3A3A3A]"
  battery=$(pmset -g batt | tail -1 | awk '{print $3}' | tr -d ';')
  calendar="#[fg=#6A9955,bg=#3A3A3A]#[fg=#262626,bg=#6A9955]  %a %-d %H:%M "

  status_right="$status_right$heart$battery% $calendar"

  tmux set  -g status-right-length          150
  tmux set  -g status-right                 "$status_right"
}

set_status_left_theme () {
  tmux set  -g status-left-length           150
  tmux set  -g status-left                  "#[fg=#262626,bg=#6A9955,bold]  #S #[fg=#6A9955,bg=#262626,nobold]"
}

set_theme () {
  # Status bar
  tmux set -g status-fg                     "#626262"
  tmux set -g status-bg                     "#262626"
  set_status_right_theme
  set_status_left_theme

  # Window status
  tmux setw -g window-status-format         " #I  #{?window_zoomed_flag,(,}#W#{?window_zoomed_flag,),} "
  tmux setw -g window-status-current-format "#[fg=#262626,bg=#363636]#[fg=white,bg=#363636] #I  #[fg=white,bg=#363636]#{?window_zoomed_flag,#[fg=red](,}#W#{?window_zoomed_flag,#[fg=red]),} #[fg=#3A3A3A,bg=#262626]"

  # Others
  tmux setw -g window-status-separator      ""                      # Window separator
  tmux setw -g window-status-current-style  "fg=#6A9955,bg=#262626" # Current window status

  tmux set  -g status-justify               left                    # Window status alignment
  tmux set  -g pane-border-style            "fg=#444444,bg=default" # Pane border
  tmux set  -g pane-active-border-style     "fg=#6A9955"            # Active pane border
  # tmux set  -g display-panes-colour         "#444444"               # Pane number indicator
  # tmux set  -g display-panes-active-colour  "#777777"               # Active pane number indicator
  tmux set  -g clock-mode-colour            "#6A9955"               # Clock mode
  tmux set  -g message-style                "fg=#6A9955,bg=#262626" # Message
  tmux set  -g message-command-style        "fg=#6A9955,bg=#262626" # Command message
  tmux set  -g mode-style                   "bg=#1D361D"            # Copy mode highlight
}

set_theme
