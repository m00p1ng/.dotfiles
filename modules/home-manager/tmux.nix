{ pkgs, config, lib, ... }:

with lib;

let
  cfg = config.programs.tmux;
in {
  config = mkIf cfg.enable {
    programs.tmux = {
      baseIndex = 1;
      clock24 = true;
      escapeTime = 50;
      historyLimit = 100000;
      keyMode = "vi";
      mouse = true;
      terminal = "\${TERM}";

      # Ref: https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/tmux-plugins/default.nix
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = battery;
          extraConfig = ''
            set -g @batt_icon_charge_tier8 ' ' # [95%-100%]
            set -g @batt_icon_charge_tier7 ' ' # [80%-95%)
            set -g @batt_icon_charge_tier6 ' ' # [65%-80%)
            set -g @batt_icon_charge_tier5 ' ' # [50%-65%)
            set -g @batt_icon_charge_tier4 ' ' # [35%-50%)
            set -g @batt_icon_charge_tier3 ' ' # [20%-35%)
            set -g @batt_icon_charge_tier2 ' ' # (5%-20%)
            set -g @batt_icon_charge_tier1 ' ' # [0%-5%]
            set -g @batt_icon_status_charged  ''
            set -g @batt_icon_status_charging ''
            set -g @batt_icon_status_attached ''
            set -g @batt_icon_status_unknown  ''
          '';
        }
        {
          plugin = prefix-highlight;
          extraConfig = ''
            set -g @prefix_highlight_fg '##D16969,bold'
            set -g @prefix_highlight_bg '##111111'
            set -g @prefix_highlight_output_prefix "["
            set -g @prefix_highlight_output_suffix "]"
            set -g @prefix_highlight_show_copy_mode 'on'
            set -g @prefix_highlight_show_sync_mode 'on'
            set -g @prefix_highlight_copy_mode_attr 'fg=##D16969,bold,bg=##111111'
            set -g @prefix_highlight_sync_mode_attr 'fg=##D16969,bold,bg=##111111'
          '';
        }
        {
          plugin = cpu;
        }
      ];

      extraConfig = ''
        set -g renumber-windows on
        set -g monitor-activity on
        set -g monitor-bell     on
        set -g visual-activity  off
        set -g activity-action  none

        bind-key '"' if-shell -F '#{window_zoomed_flag}' 'resize-pane -Z' 'split-window -v -c "#{pane_current_path}"'
        bind-key %   if-shell -F '#{window_zoomed_flag}' 'resize-pane -Z' 'split-window -h -c "#{pane_current_path}"'
        bind-key c   new-window -c "#{pane_current_path}"

        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

        is_fzf="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?fzf$'"

        is_browsh="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?browsh$'"

        bind-key -n 'C-h' if-shell "$is_vim"                 'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "($is_vim || $is_fzf)"    'send-keys C-j'  'select-pane -D'
        bind-key -n 'C-k' if-shell "($is_vim || $is_fzf)"    'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "($is_vim || $is_browsh)" 'send-keys C-l'  'select-pane -R'
        bind-key -n 'C-\' if-shell "$is_vim"                 'send-keys C-\\' 'send-keys -R C-l; clear-history'

        bind-key -r H resize-pane -L 5
        bind-key -r J resize-pane -D 5
        bind-key -r K resize-pane -U 5
        bind-key -r L resize-pane -R 5

        bind-key -n 'M-[' swap-window -d -t-
        bind-key -n 'M-]' swap-window -d -t+

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R

        bind-key -T copy-mode-vi v send -X begin-selection
        bind-key -T copy-mode-vi V send -X select-line
        bind-key -T copy-mode-vi y                 send -X copy-pipe-and-cancel 'pbcopy'
        bind-key -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel 'pbcopy'
        bind-key -n M-w display-menu -x W -y S \
          "New Session"                        S "command-prompt -p \"New Session:\" \"new-session -A -s '%%'\"" \
          "Kill Session"                       x "kill-session" \
          "Kill Other Session(s)"              X "kill-session -a" \
          "" \
          "New Window"                         ␍ new-window \
          "Kill Window"                        k "killw"  \
          "Choose Window"                      w choose-window \
          "Previous Window"                    🡠 previous-window \
          "Next Window"                        🡢 next-window \
          "Swap Window Right"                  ↑ "swap-window -t -1" \
          "Swap Window Left"                   ↓ "swap-window -t +1" \
          "Horizontal Split"                   v "split-window -h" \
          "Vertical Split"                     s "split-window -v"  \
          "" \
          "Layout Horizontal"                  h "select-layout even-horizontal"  \
          "Layout Vertical"                    k "select-layout even-horizontal"  \
          "" \
          "Swap Pane Up"                       < "swap-pane -U" \
          "Swap Pane Down"                     > "swap-pane -D" \
          "Break Pane"                         t break-pane \
          "Join Pane"                          j "choose-window 'join-pane -h -s \"%%\"'" \
          "#{?window_zoomed_flag,Unzoom,Zoom}" z "resize-pane -Z"
      '';
    };

    xdg.configFile."tmux/tmux.conf".text = mkBefore ''
      #############
      ##  Theme  ##
      #############

      # Title
      set -g set-titles         on
      set -g set-titles-string  "#T (tmux)"
      set -g automatic-rename on
      set -g automatic-rename-format '#{?#{||:#{==:#{pane_current_command},nvim},#{==:#{pane_current_command},fish}},#{b:pane_current_path},#{pane_current_command}}'

      # Status options
      set -g status               on
      set -g status-interval      1
      set -g status-position      top
      set -g status-justify       left
      set -g status-left-length   150
      set -g status-right-length  150

      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'                                                         # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

      run-shell ${config.xdg.configHome}/tmux/theme.sh
    '';

    xdg.configFile."tmux" = {
      source = ./config/tmux;
      recursive = true;
    };
  };
}
