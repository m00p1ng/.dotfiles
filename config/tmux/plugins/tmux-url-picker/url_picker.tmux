#!/usr/bin/env bash
# tmux-url-picker — bind the URL picker for the current tmux server.

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
key="$(tmux show-option -gqv @url-picker-key)"

tmux bind-key -N "Open URL from current pane" "${key:-u}" \
  run-shell -b "$current_dir/url_picker.py"
