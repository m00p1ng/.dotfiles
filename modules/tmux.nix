{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 300;
    historyLimit = 50000;
    keyMode = "vi";
    terminal = "\${TERM}";

    extraConfig = ''
      set -g mouse            on
      set -g renumber-windows on

      bind '"' split-window -v -c "#{pane_current_path}"
      bind %   split-window -h -c "#{pane_current_path}"
      bind c   new-window   -c    "#{pane_current_path}"

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'     'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'     'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'     'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'     'select-pane -R'
      bind-key -n 'C-\' if-shell "$is_vim" 'send-keys C-\\'    'send-keys C-l \\; clear-history'


      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R

      #############
      ##  Theme  ##
      #############

      # Status options
      set -g status-interval               1
      set -g status                        on
      set -g status-fg                     "#626262"
      set -g status-bg                     "#262626"

      # Left side of status bar
      set  -g status-left-length           150
      set  -g status-left                  "#[fg=#262626,bg=#77DD77,bold]  #S #[fg=#77DD77,bg=#262626,nobold]"

      # Right side of status bar
      set  -g status-right-length          150
      set  -g status-right                 "#[fg=#3A3A3A,bg=#262626]#[fg=colour009,bg=#3A3A3A] ♥ #[fg=white,bg=#3A3A3A]#(pmset -g batt | tail -1 | awk '{print $3}' | tr -d ';') #[fg=#77DD77,bg=#3A3A3A]#[fg=#262626,bg=#77DD77]  %a %-d %H:%M "

      # Window status
      setw -g window-status-format         " #I ⮁ #{?window_zoomed_flag,(,}#W#{?window_zoomed_flag,),} "
      setw -g window-status-current-format "#[fg=#262626,bg=#363636]⮀#[fg=white,bg=#363636] #I ⮁#[fg=white,bg=#363636] #{?window_zoomed_flag,#[fg=red](,}#W#{?window_zoomed_flag,#[fg=red]),} #[fg=#3A3A3A,bg=#262626]⮀"

      # Others
      setw -g window-status-separator      ""                      # Window separator
      setw -g window-status-current-style  "fg=#77DD77,bg=#262626" # Current window status

      set  -g status-justify               left                    # Window status alignment
      set  -g pane-border-style            "fg=#444444,bg=default" # Pane border
      set  -g pane-active-border-style     "fg=#77DD77"            # Active pane border
      set  -g display-panes-colour         "#444444"               # Pane number indicator
      set  -g display-panes-active-colour  "#777777"               # Active pane number indicator
      set  -g clock-mode-colour            "#77DD77"               # Clock mode
      set  -g message-style                "fg=#77DD77,bg=#262626" # Message
      set  -g message-command-style        "fg=#77DD77,bg=#262626" # Command message
      set  -g mode-style                   "bg=#1D361D"            # Copy mode highlight

      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
    '';
  };
}
