FG="#626262"
BG="#111111"
TC="#6A9955"
MT="#613214"
SC="#264F78"
AP="#D16969"
AT="#272727"
TX="#CCCCCC"
WN="#E8AB53"

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZOOM_ICON=""

make_bubble () {
  prefix="#[fg=$AT,bg=$BG]#[fg=#$TX,bg=$AT]"
  suffix="#[fg=$AT,bg=$BG]"

  icon="#[fg=#$AP,bg=$AT]$1#[fg=#$TX,bg=$AT]"
  value="$2"

  if [ "$value" = "" ]; then
    echo "$prefix$icon$suffix"
  else
    echo "$prefix$icon $value$suffix"
  fi
}

date_widget () {
  icon=""
  date="%a %-d %H:%M"
  make_bubble "$icon" "$date"
}

battery_widget () {
  icon="#{battery_icon}"
  value="#{battery_percentage}"
  make_bubble "$icon" "$value"
}

wifi_widget () {
  icon="#($CURRENT_DIR/scripts/wifi_icon.sh)"
  value="#($CURRENT_DIR/scripts/wifi.sh)"
  make_bubble "$icon" "$value"
}

keyboard_widget () {
  icon=""
  value="#($CURRENT_DIR/scripts/keyboard.sh)"
  make_bubble "$icon" "$value"
}

prefix_widget () {
  echo "#{prefix_highlight}"
}

set_right_status_theme () {
  widget=(
    "$(prefix_widget)"
    "$(keyboard_widget)"
    "$(wifi_widget)"
    "$(battery_widget)"
    "$(date_widget)"
  )
  joined_widget=$(IFS=' ' ; echo "${widget[*]}")
  echo "$joined_widget"
}

set_left_status_theme () {
  echo "#[fg=$BG,bg=$TC,bold]  #S#[fg=$TC,bg=$BG] "
}

set_window_status_theme () {
  zoom_suffix="#{?window_zoomed_flag,$ZOOM_ICON,}"
  echo "  #I #W$zoom_suffix  "
}

set_window_status_current_theme () {
  current_zoom_prefix="#{?window_zoomed_flag,#[fg=#$WN],#[fg=#$TX]}#[italics]"
  current_zoom_suffix="#{?window_zoomed_flag,$ZOOM_ICON,}"
  make_bubble " #[bold]#I" "$current_zoom_prefix#W$current_zoom_suffix "
}

set_theme () {
  # Status bar
  tmux set -g status-fg           "$FG"
  tmux set -g status-bg           "$BG"
  tmux set -g status-left         "$(set_left_status_theme)"
  tmux set -g status-left-length  150
  tmux set -g status-right        "$(set_right_status_theme)"
  tmux set -g status-right-length 150

  # Others
  tmux set -g window-status-format           "$(set_window_status_theme)"
  tmux set -g window-status-current-format   "$(set_window_status_current_theme)"
  tmux set -g window-status-separator        ""
  tmux set -g window-status-current-style    "fg=$TC,bg=$BG"

  tmux set -g status-justify                 left
  tmux set -g pane-border-style              "fg=$AT"
  tmux set -g pane-active-border-style       "fg=$TC"
  tmux set -g clock-mode-colour              "$TC"
  tmux set -g message-style                  "fg=$TC,bg=$BG"
  tmux set -g message-command-style          "fg=$TC,bg=$BG"
  tmux set -g mode-style                     "fg=$TX,bg=$SC"
  tmux set -g copy-mode-match-style          "fg=$TX,bg=$MT"
  tmux set -g copy-mode-current-match-style  "fg=$TX,bg=$SC"
}

set_theme
