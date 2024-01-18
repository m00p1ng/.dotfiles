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
ZOOM_ICON="󰪥"
BELL_ICON="󱅫"
ACTIVITY_ICON="●"
SEP=' '
PADDING='  '

hide_on_width () {
  value="${1//,/#,}"
  width=$2
  template="#{e|>:#{client_width},$width}"
  echo "#{?$template,$value,}"
}

make_status () {
  icon="#[fg=#$AP]$1#[fg=#$TX]"
  sep="$2"
  value="$3"

  echo "$icon$sep$value"
}

make_bubble () {
  prefix="#[fg=$AT,bg=$BG]#[fg=#$TX,bg=$AT]"
  suffix="#[fg=$AT,bg=$BG]"

  text=$(make_status "$1" "$2" "$3")

  echo "$prefix$text$suffix"
}

date_widget () {
  icon=""
  value="%a %-d %H:%M"
  output=$(make_status "$icon" "$SEP" "$value")
  hide_on_width "$output" 100
}

battery_widget () {
  icon="#{battery_icon}"
  value="#{battery_percentage}"
  output=$(make_status "$icon" "$SEP" "$value")
  hide_on_width "$output$PADDING" 100
}

wifi_widget () {
  icon="#($CURRENT_DIR/scripts/wifi_icon.sh)"
  value="#($CURRENT_DIR/scripts/wifi.sh)"
  output=$(make_status "$icon" "" "$value")
  hide_on_width "$output$PADDING" 120
}

keyboard_widget () {
  icon="󰌌"
  value="#($CURRENT_DIR/scripts/keyboard.sh)"
  output=$(make_status "$icon" "$SEP" "$value")
  hide_on_width "$output$PADDING" 140
}

exchange_widget () {
  icon=""
  value="#($CURRENT_DIR/scripts/exchange.sh)"
  output=$(make_status "$icon" "$SEP" "$value")
  hide_on_width "$output$PADDING" 140
}

prefix_widget () {
  echo "#{prefix_highlight}"
  hide_on_width "$PADDING" 100
}

cpu_widget () {
  icon="󰍛"
  value="#{cpu_percentage}"
  output=$(make_status "$icon" "$SEP" "$value")
  hide_on_width "$output$PADDING" 140
}

set_right_status_theme () {
  widget=(
    "$(prefix_widget)"
    "$(cpu_widget)"
    "$(ram_widget)"
    "$(exchange_widget)"
    "$(keyboard_widget)"
    "$(wifi_widget)"
    "$(battery_widget)"
    "$(date_widget)"
  )
  joined_widget=$(IFS='' ; echo "${widget[*]}")
  echo "$joined_widget"
  hide_on_width "$SEP" 100
}

set_left_status_theme () {
  echo "#[fg=$BG,bg=$TC,bold]  #S#[fg=$TC,bg=$BG] "
}

set_window_status_theme () {
  activity_icon="#{?window_activity_flag,#[fg=#$TC]$ACTIVITY_ICON#[fg=$FG],#I}"
  bell_icon="#{?window_bell_flag,#[fg=#$WN]$BELL_ICON#[fg=#$FG],$activity_icon}"
  pane_icon="$bell_icon"
  echo "  $pane_icon #W  "
}

set_window_status_current_theme () {
  pane_icon="#{?window_zoomed_flag,$ZOOM_ICON,#I}"
  make_bubble " #[bold]$pane_icon" "$SEP" "#[fg=#$TX,italics]#W "
}

set_automatic_rename_format () {
  is_nvim="#{==:#{pane_current_command},nvim}"
  is_fish="#{==:#{pane_current_command},fish}"
  path_format="#{?#{==:#{pane_current_path},#{HOME}},~ (#{pane_current_command}),#{b:pane_current_path}}"

  echo "#{?#{||:$is_nvim,$is_fish},$path_format,#{pane_current_command}}"
}

set_theme () {
  # Status bar
  tmux set -g status-style  "fg=$FG,bg=$BG"
  tmux set -g status-left   "$(set_left_status_theme)"
  tmux set -g status-right  "$(set_right_status_theme)"
  tmux set -g automatic-rename-format "$(set_automatic_rename_format)"

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
