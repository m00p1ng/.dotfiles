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
      focusEvents = true;
      historyLimit = 100000;
      keyMode = "vi";
      mouse = true;
      terminal = "\${TERM}";

      # Ref: https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/tmux-plugins/default.nix
      plugins = with pkgs.tmuxPlugins; [
        # {
        #   plugin = battery;
        #   extraConfig = ''
        #     set -g @batt_icon_charge_tier8 ' ' # [95%-100%]
        #     set -g @batt_icon_charge_tier7 ' ' # [80%-95%)
        #     set -g @batt_icon_charge_tier6 ' ' # [65%-80%)
        #     set -g @batt_icon_charge_tier5 ' ' # [50%-65%)
        #     set -g @batt_icon_charge_tier4 ' ' # [35%-50%)
        #     set -g @batt_icon_charge_tier3 ' ' # [20%-35%)
        #     set -g @batt_icon_charge_tier2 ' ' # (5%-20%)
        #     set -g @batt_icon_charge_tier1 ' ' # [0%-5%]
        #     set -g @batt_icon_status_charged  ''
        #     set -g @batt_icon_status_charging ''
        #     set -g @batt_icon_status_attached ''
        #     set -g @batt_icon_status_unknown  ''
        #   '';
        # }
        {
          plugin = prefix-highlight;
          extraConfig = ''
            set -g @prefix_highlight_fg '##f38ba8,bold'
            set -g @prefix_highlight_bg '##1e1e2e'
            set -g @prefix_highlight_output_prefix "["
            set -g @prefix_highlight_output_suffix "]"
            set -g @prefix_highlight_show_copy_mode 'on'
            set -g @prefix_highlight_show_sync_mode 'on'
            set -g @prefix_highlight_copy_mode_attr 'fg=##f38ba8,bold,bg=##1e1e2e'
            set -g @prefix_highlight_sync_mode_attr 'fg=##f38ba8,bold,bg=##1e1e2e'
          '';
        }
        {
          plugin = fzf-tmux-url;
          extraConfig = ''
            set -g @fzf-url-fzf-options '-w 50% -h 50% --multi -0 --no-preview'
          '';
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

        #############
        ##  Theme  ##
        #############

        # Title
        set -g set-titles         on
        set -g set-titles-string  "#T (tmux)"
        set -g automatic-rename on

        # Status options
        set -g status               on
        set -g status-interval      1
        set -g status-position      top
        set -g status-justify       left
        set -g status-left-length   150
        set -g status-right-length  150

        set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'                                                         # undercurl support
        set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
      '';
    };

    xdg.configFile."tmux/tmux.conf".text = mkBefore ''
      run-shell ${config.xdg.configHome}/tmux/theme.sh
    '';

    xdg.configFile."tmux" = {
      source = ../../config/tmux;
      recursive = true;
    };

    # auto attach tmux configuration
    programs.fish = {
      interactiveShellInit = ''
        if not set -q TMUX
          set tmux_default_session_name workspace
          set tmux_attached_client (tmux list-clients 2> /dev/null | grep $tmux_default_session_name | wc -l)
          set tmux_has_default_session (tmux ls 2> /dev/null | grep $tmux_default_session_name | wc -l)

          if [ $tmux_attached_client -eq 0 ]
            if [ $tmux_has_default_session -eq 0 ]
              tmux new -s $tmux_default_session_name
            else
              tmux a -t $tmux_default_session_name
            end
          else
            tmux
          end
        end
      '';
    };
  };
}
