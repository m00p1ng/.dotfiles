{ pkgs, config, ... }:

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

      # Title
      set -g set-titles         on
      set -g set-titles-string  "#T [tmux]"

      # Status options
      set -g status-interval  1
      set -g status           on
      set -g status-position  top

      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'                                                         # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

      run-shell ${config.xdg.configHome}/tmux/theme.sh
    '';
  };

  xdg.configFile."tmux" = {
    source = ../configs/tmux;
    recursive = true;
  };
}
