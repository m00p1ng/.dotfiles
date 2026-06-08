{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  inherit (pkgs) tmuxPlugins;

  cfg = config.programs.tmux;

  # https://github.com/junegunn/tmux-fzf-url
  fzfUrlPlugin = {
    plugin = tmuxPlugins.mkTmuxPlugin {
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
  };

  interactiveProcessPattern = concatStringsSep "|" cfg.interactivePrograms;

  cleanCmd = "#{s/^\\\\.(.+)-wrap.*$/\\\\1/:pane_current_command}";
  isNvim = "#{==:${cleanCmd},nvim}";
  isFish = "#{==:${cleanCmd},fish}";
  pathFmt = "#{?#{==:#{pane_current_path},#{HOME}},~ (${cleanCmd}),#{b:pane_current_path}}";
  renameFmt = "#{?#{||:${isNvim},${isFish}},${pathFmt},${cleanCmd}}";

  interactiveNavigatorConfig =
    if cfg.isInteractivePatch
    then
      #bash
      ''
        # https://github.com/christoomey/vim-tmux-navigator/issues/417
        is_interactive="ps -o tty= -o state= -o comm= \
          | grep -iqE '^#{s|/dev/||:pane_tty} +[^TXZ ]+ +(\\S+\\/)?(${interactiveProcessPattern})$'"
      ''
    else
      #bash
      ''
        is_interactive="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?(${interactiveProcessPattern})$'"
      '';
in {
  options.programs.tmux = {
    isInteractivePatch = mkEnableOption "interactive patch";
    interactivePrograms = mkOption {
      type = types.listOf types.str;
    };
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
        fzfUrlPlugin
        {
          # https://github.com/catppuccin/tmux
          plugin = catppuccin;
          extraConfig =
            #bash
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
              set -g status-right "#{E:@catppuccin_status_date_time}"
            '';
        }
      ];

      interactivePrograms = ["vi" "vim" "view"];
      extraConfig =
        #bash
        ''
          set -g renumber-windows on
          set -g monitor-activity on
          set -g monitor-bell     on
          set -g visual-activity  off
          set -g activity-action  none
          set -g allow-passthrough on
          set -g extended-keys     on

          bind-key -N "Split window vertically"   '"' if-shell -F '#{window_zoomed_flag}' 'resize-pane -Z' 'split-window -v -c "#{pane_current_path}"'
          bind-key -N "Split window horizontally" %   if-shell -F '#{window_zoomed_flag}' 'resize-pane -Z' 'split-window -h -c "#{pane_current_path}"'
          bind-key -N "New window"                c   new-window -c "#{pane_current_path}"
          bind-key -N "Join pane"                 j   choose-tree -Z "join-pane -t %%"
          bind-key -N "New session"               S   command-prompt -p "New session name:" -I "" "new-session -s '%%'"
          bind-key -N "Rename pane"               P   command-prompt -p "(rename-pane)" -I "#{pane_title}" "select-pane -T '%%'"
          bind-key -N "Toggle pane border status" +   if-shell -F '#{||:#{==:#{pane-border-status},top},#{==:#{pane-border-status},}}' 'set pane-border-status off' 'set pane-border-status top'

          ${interactiveNavigatorConfig}

          bind-key -n -N "Select pane left"         'C-h' if-shell "$is_interactive" 'send-keys C-h'  'select-pane -L'
          bind-key -n -N "Select pane down"         'C-j' if-shell "$is_interactive" 'send-keys C-j'  'select-pane -D'
          bind-key -n -N "Select pane up"           'C-k' if-shell "$is_interactive" 'send-keys C-k'  'select-pane -U'
          bind-key -n -N "Select pane right"        'C-l' if-shell "$is_interactive" 'send-keys C-l'  'select-pane -R'
          bind-key -n -N "Clear screen and history" 'C-\' if-shell "$is_interactive" 'send-keys C-\\' 'send-keys -R C-l; clear-history'

          bind-key -r -N "Resize pane left"  H resize-pane -L 5
          bind-key -r -N "Resize pane down"  J resize-pane -D 5
          bind-key -r -N "Resize pane up"    K resize-pane -U 5
          bind-key -r -N "Resize pane right" L resize-pane -R 5

          # NOTE: Don't map with `M-[` and `M-]`
          bind-key -n -N "Swap window left"      'M-{' swap-window -d -t-
          bind-key -n -N "Swap window right"     'M-}' swap-window -d -t+
          bind-key -n -N "Switch to last client" 'M-l' switch-client -l

          bind-key -T copy-mode-vi -N "Select pane left"  'C-h' select-pane -L
          bind-key -T copy-mode-vi -N "Select pane down"  'C-j' select-pane -D
          bind-key -T copy-mode-vi -N "Select pane up"    'C-k' select-pane -U
          bind-key -T copy-mode-vi -N "Select pane right" 'C-l' select-pane -R

          bind-key -T copy-mode-vi -N "Begin selection"        v send -X begin-selection
          bind-key -T copy-mode-vi -N "Select line"            V send -X select-line
          bind-key -T copy-mode-vi -N "Copy selection"         y                 send -X copy-pipe-and-cancel 'pbcopy'
          bind-key -T copy-mode-vi -N "Copy selection on drag" MouseDragEnd1Pane send -X copy-pipe-and-cancel 'pbcopy'

          #############
          ##  Theme  ##
          #############

          # Title
          set -g set-titles         on
          set -g set-titles-string  "#T (tmux)"
          set -g automatic-rename on
          set -g automatic-rename-format "${renameFmt}"

          # Pane
          set -g pane-border-format "#[fg=#{@thm_peach},bg=#{@thm_surface_0}] #{?#{@pinned_title},#{@pinned_title},#{pane_title}} #[default]"
          # set-hook -g after-resize-pane \
          #   'if-shell -F "#{window_zoomed_flag}" "set pane-border-status off" "set pane-border-status #{?#{@border_toggle},#{@border_toggle},top}"'

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
  };
}
