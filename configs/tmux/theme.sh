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
ZOOM_ICON=""
BELL_ICON=""
ACTIVITY_ICON="ﱣ"

hide_on_width () {
  value=$(echo $1 | sed "s/,/#,/g")
  width=$2
  template="#{e|>:#{client_width},$width}"
  echo "#{?$template,$value,}"
}

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
  output=$(make_bubble "$icon" "$value")
  hide_on_width "$output" 80
}

battery_widget () {
  icon="#{battery_icon}"
  value="#{battery_percentage}"
  output=$(make_bubble "$icon" "$value")
  hide_on_width "$output" 100
}

wifi_widget () {
  icon="#($CURRENT_DIR/scripts/wifi_icon.sh)"
  value="#($CURRENT_DIR/scripts/wifi.sh)"
  output=$(make_bubble "$icon" "$value")
  hide_on_width "$output" 120
}

keyboard_widget () {
  icon=""
  value="#($CURRENT_DIR/scripts/keyboard.sh)"
  output=$(make_bubble "$icon" "$value")
  hide_on_width "$output" 140
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
  activity_icon="#{?window_activity_flag,#[fg=#$TC#,italics#,bold]$ACTIVITY_ICON#[fg=$FG],#I}"
  bell_icon="#{?window_bell_flag,#[fg=#$WN#,italics#,bold]$BELL_ICON#[fg=#$FG],$activity_icon}"
  pane_icon="$bell_icon"
  echo "  $pane_icon #W  "
}

set_window_status_current_theme () {
  pane_icon="#{?window_zoomed_flag,$ZOOM_ICON,#I}"
  make_bubble " #[bold]$pane_icon" "#[fg=#$TX,italics]#W "
}

set_theme () {
  # Status bar
  tmux set -g status-fg           "$FG"
  tmux set -g status-bg           "$BG"
  tmux set -g status-left         "$(set_left_status_theme)"
  tmux set -g status-left-length  150
  tmux set -g status-right        "$(set_right_status_theme)"
  tmux set -g status-right-length 150

  # Window status
  tmux set -g window-status-format           "$(set_window_status_theme)"
  tmux set -g window-status-current-format   "$(set_window_status_current_theme)"
  tmux set -g window-status-separator        ""
  tmux set -g window-status-current-style    "fg=$TC,bg=$BG"
  tmux set -g window-status-activity-style   "none"
  tmux set -g window-status-bell-style       "none"

  # Others
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
