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
        {
          # https://github.com/junegunn/tmux-fzf-url
          plugin = mkTmuxPlugin {
            pluginName = "tmux-fzf-url";
            version = "unstable-2024-12-31";
            rtpFilePath = "fzf-url.tmux";
            src = pkgs.fetchFromGitHub {
              owner = "m00p1ng";
              repo = "tmux-fzf-url";
              rev = "2df0c7e82bf923746208d47cb3fba5c44a2ccb97";
              sha256 = "sha256-x5BBZGfCQNr1++RwF8T6XsI9qT6Na7ivYbPbvzTp3G8=";
            };
          };
        }
        {
          # https://github.com/catppuccin/tmux
          plugin = catppuccin.overrideAttrs ( _: {
            src = pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "tmux";
              rev = "ba9bd88c98c81f25060f051ed983e40f82fdd3ba";
              sha256 = "sha256-HegD89d0HUJ7dHKWPkiJCIApPY/yqgYusn7e1LDYS6c=";
            };
          });
          extraConfig = ''
            set -g @catppuccin_flavor 'mocha'

            # Pane styling options
            set -g @catppuccin_pane_border_style "fg=#{@thm_mantle}"
            set -g @catppuccin_pane_active_border_style "##{?pane_in_mode,fg=#{@thm_peach},##{?pane_synchronized,fg=#{@thm_peach},fg=#{@thm_green}}}"

            # Window options
            set -g @catppuccin_window_status_style "rounded"
            set -g @catppuccin_window_number_color "#{@thm_bg}"
            set -g @catppuccin_window_text "#[fg=#{@thm_surface_2},bg=#{@thm_bg}]#W "
            set -g @catppuccin_window_number "#[fg=#{@thm_surface_2},bg=#{@thm_bg}]#{?window_activity_flag,#[fg=#{@thm_mauve}]●,#I}"
            set -g @catppuccin_window_number_position "left"
            set -g @catppuccin_window_current_number_color "#{?window_zoomed_flag,#{@thm_red},#{@thm_peach}}"
            set -g @catppuccin_window_current_text "#[bg=#{@thm_surface_0}] #[italics,bold]#W"
            set -g @catppuccin_window_current_number "#{?window_zoomed_flag,,#I}"

            # Status line options
            set -g @catppuccin_status_background "#{@thm_bg}"
            set -g @catppuccin_status_left_separator  ""
            set -g @catppuccin_status_right_separator ""
            set -g @catppuccin_status_middle_separator ""
            set -g @catppuccin_status_fill "icon"
            set -g @catppuccin_status_connect_separator "no"

            set -g @catppuccin_date_time_color "#{@thm_blue}"
            set -g @catppuccin_date_time_text " %a %-d %H:%M"
            set -g @catppuccin_session_color "#{?client_prefix,#{@thm_red},#{?pane_in_mode,#{@thm_peach},#{?pane_synchronized,#{@thm_peach},#{@thm_green}}}}"


            set -g status-left '#{E:@catppuccin_status_session} '
            set -g status-right '#{E:@catppuccin_status_date_time}'
          '';
        }
      ];

      extraConfig = ''
        set -g renumber-windows on
        set -g monitor-activity on
        set -g monitor-bell     on
        set -g visual-activity  off
        set -g activity-action  none
        set -g allow-passthrough on

        bind-key '"' if-shell -F '#{window_zoomed_flag}' 'resize-pane -Z' 'split-window -v -c "#{pane_current_path}"'
        bind-key %   if-shell -F '#{window_zoomed_flag}' 'resize-pane -Z' 'split-window -h -c "#{pane_current_path}"'
        bind-key c   new-window -c "#{pane_current_path}"
        bind-key j   choose-tree -Z "join-pane -t %%"

        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

        is_fzf="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?fzf$'"

        bind-key -n 'C-h' if-shell "$is_vim"              'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "($is_vim || $is_fzf)" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'C-k' if-shell "($is_vim || $is_fzf)" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim"              'send-keys C-l'  'select-pane -R'
        bind-key -n 'C-\' if-shell "$is_vim"              'send-keys C-\\' 'send-keys -R C-l; clear-history'

        bind-key -r H resize-pane -L 5
        bind-key -r J resize-pane -D 5
        bind-key -r K resize-pane -U 5
        bind-key -r L resize-pane -R 5

        # NOTE: Don't map with `M-[` and `M-]`
        bind-key -n 'M-{' swap-window -d -t-
        bind-key -n 'M-}' swap-window -d -t+

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

        # catppuccin
        set -g copy-mode-match-style          "fg=#{@thm_fg},bg=#{@thm_surface_1}"
        set -g copy-mode-current-match-style  "fg=#{@thm_surface_1},bg=#{@thm_red}"
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
