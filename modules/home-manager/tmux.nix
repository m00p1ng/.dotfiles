{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  inherit (pkgs) tmuxPlugins;

  cfg = config.programs.tmux;
  scriptsPath = "${config.xdg.configHome}/tmux/scripts";

  # ref: https://github.com/christoomey/vim-tmux-navigator/issues/418
  is_vim =
    pkgs.writeShellScriptBin "is_vim.sh"
    /*
    bash
    */
    ''
      pane_pid=$(tmux display -p "#{pane_pid}")

      [ -z "$pane_pid" ] && exit 1

      # Retrieve all descendant processes of the tmux pane's shell by iterating through the process tree.
      # This includes child processes and their descendants recursively.
      descendants=$(ps -eo pid=,ppid=,stat= | awk -v pid="$pane_pid" '{
          if ($3 !~ /^T/) {
              pid_array[$1]=$2
          }
      } END {
          for (p in pid_array) {
              current_pid = p
              while (current_pid != "" && current_pid != "0") {
                  if (current_pid == pid) {
                      print p
                      break
                  }
                  current_pid = pid_array[current_pid]
              }
          }
      }')

      if [ -n "$descendants" ]; then

          descendant_pids=$(echo "$descendants" | tr '\n' ',' | sed 's/,$//')

          ps -o args= -p "$descendant_pids" | grep -iqE "(^|/)([gn]?vim?x?|fzf|tv)(diff)?";

          if [ $? -eq 0 ]; then
              exit 0
          fi
      fi

      exit 1
    '';
in {
  options.programs.tmux = {
    meeting = {
      enable = mkEnableOption "meeting plugin";
    };
    is_vim_patch = mkEnableOption "is_vim patch";
  };

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
      plugins = with tmuxPlugins; [
        {
          # https://github.com/junegunn/tmux-fzf-url
          plugin = mkTmuxPlugin {
            pluginName = "tmux-fzf-url";
            version = "unstable-2025-04-08";
            rtpFilePath = "fzf-url.tmux";
            src = pkgs.fetchFromGitHub {
              owner = "m00p1ng";
              repo = "tmux-fzf-url";
              rev = "306c0701454edb173a79b7085b5b5af1a3451f59";
              sha256 = "sha256-EO/JXWRgM/KH1b53LHTnAFY2ys/K4YpwNo93QIl9yEo=";
            };
          };
        }
        {
          # https://github.com/catppuccin/tmux
          plugin = catppuccin;
          extraConfig =
            /*
            bash
            */
            ''
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

              set -g @catppuccin_date_time_icon " "
              set -g @catppuccin_date_time_color "#{@thm_blue}"
              set -g @catppuccin_date_time_text " %a %-d %H:%M"
              set -g @catppuccin_session_color "#{?client_prefix,#{@thm_red},#{?pane_in_mode,#{@thm_peach},#{?pane_synchronized,#{@thm_peach},#{@thm_green}}}}"


              set -g status-left "#{E:@catppuccin_status_session} "
              ${
                if cfg.meeting.enable
                then ''set -g status-right "#{E:@catppuccin_status_meeting} #{E:@catppuccin_status_date_time}"''
                else ''set -g status-right "#{E:@catppuccin_status_date_time}"''
              }
            '';
        }
      ];

      extraConfig =
        /*
        bash
        */
        ''
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

          ${
            if cfg.is_vim_patch
            then
              /*
              bash
              */
              ''
                bind-key -n 'C-h' if-shell "${is_vim}/bin/is_vim.sh" 'send-keys C-h'  'select-pane -L'
                bind-key -n 'C-j' if-shell "${is_vim}/bin/is_vim.sh" 'send-keys C-j'  'select-pane -D'
                bind-key -n 'C-k' if-shell "${is_vim}/bin/is_vim.sh" 'send-keys C-k'  'select-pane -U'
                bind-key -n 'C-l' if-shell "${is_vim}/bin/is_vim.sh" 'send-keys C-l'  'select-pane -R'
                bind-key -n 'C-\' if-shell "${is_vim}/bin/is_vim.sh" 'send-keys C-\\' 'send-keys -R C-l; clear-history'
              ''
            else
              /*
              bash
              */
              ''
                is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
                  | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?|fzf|tv)(diff)?$'"

                bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
                bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
                bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
                bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
                bind-key -n 'C-\' if-shell "$is_vim" 'send-keys C-\\' 'send-keys -R C-l; clear-history'
              ''
          }

          bind-key -r H resize-pane -L 5
          bind-key -r J resize-pane -D 5
          bind-key -r K resize-pane -U 5
          bind-key -r L resize-pane -R 5

          # NOTE: Don't map with `M-[` and `M-]`
          bind-key -n 'M-{' swap-window -d -t-
          bind-key -n 'M-}' swap-window -d -t+
          bind-key -n 'M-l' switch-client -l

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
          ${optionalString cfg.meeting.enable ''
            source -F "${config.xdg.configHome}/tmux/status/meeting.conf"
          ''}
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

    xdg.configFile."tmux/status/meeting.conf".text =
      /*
      bash
      */
      ''
        # vim:set ft=tmux:
        %hidden MODULE_NAME="meeting"

        set -ogq "@catppuccin_''${MODULE_NAME}_icon" "#(${scriptsPath}/meeting.sh icon)"
        set -ogq "@catppuccin_''${MODULE_NAME}_color" "#{E:@thm_mauve}"
        set -ogq "@catppuccin_''${MODULE_NAME}_text" " #(${scriptsPath}/meeting.sh title)"

        source -F "${tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/utils/status_module.conf"
      '';

    home.packages = mkIf cfg.meeting.enable (with pkgs; [
      icalBuddy
    ]);
  };
}
