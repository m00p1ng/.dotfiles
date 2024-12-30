set_automatic_rename_format() {
  is_nvim="#{==:#{pane_current_command},nvim}"
  is_fish="#{==:#{pane_current_command},fish}"
  path_format="#{?#{==:#{pane_current_path},#{HOME}},~ (#{pane_current_command}),#{b:pane_current_path}}"

  echo "#{?#{||:$is_nvim,$is_fish},$path_format,#{pane_current_command}}"
}

tmux set -g automatic-rename-format "$(set_automatic_rename_format)"
