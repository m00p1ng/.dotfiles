{
  programs.kitty = {
    settings = {
      # Patched font
      # ref: https://www.reddit.com/r/KittyTerminal/comments/r5hssh/kitty_nerd_fonts/
      font_size = 14;
      font_family = "JetBrainsMono";
      modify_font = "cell_height 110%";

      cursor_shape = "beam";
      cursor_blink_interval = 0;
      disable_ligatures = "cursor";

      scrollback_lines = 10000;

      tab_bar_edge = "top";
      tab_bar_style = "slant";

      macos_quit_when_last_window_closed = "yes";
      macos_option_as_alt = "yes";

      kitty_mod = "cmd+shift";

      # Ctrl and click to open a link
      mouse_map = "cmd+left release grabbed,ungrabbed mouse_handle_click link";

      ### Theme
      background =            "#1E1E1E";
      foreground =            "#CCCCCC";

      cursor =                "#CCCCCC";
      cursor_text_color =     "#FFFEFE";

      selection_foreground =  "#191919";
      selection_background =  "#B2B2B2";

      # black
      color0 =                "#000000";
      color8 =                "#666666";

      # red
      color1 =                "#CD3131";
      color9 =                "#F14C4C";

      # green
      color2 =                "#0FBC79";
      color10 =               "#24D18B";

      # yellow
      color3 =                "#E5E50E";
      color11 =               "#F5F543";

      # blue
      color4 =                "#2372C8";
      color12 =               "#3B8EEA";

      # purple
      color5 =                "#BC3FBC";
      color13 =               "#D670D6";

      # cyan
      color6 =                "#12A7CD";
      color14 =               "#28B8DB";

      # white
      color7 =                "#e5e5e5";
      color15 =               "#e5e5e5";
    };
    keybindings = {
      # Full screen
      "cmd+enter" = "toggle_fullscreen";

      # Delete
      "cmd+backspace" = "send_text all \\x15";
      "alt+backspace" = "send_text all \\x17";

      # Tmux mapping
      # ref: https://www.joshmedeski.com/posts/macos-keyboard-shortcuts-for-tmux
      "cmd+a" = "send_text all \\x1b\\x67\\x67\\x56\\x47";
      "cmd+t" = "send_text all \\x02\\x63";
      "cmd+w" = "send_text all \\x02\\x78";
      "cmd+," = "send_text all \\x02\\x2c";
      "cmd+f" = "send_text all \\x02\\x5b\\x3f";
      "cmd+r" = "send_text all \\x02\\x5b";
      "cmd+shift+enter" = "send_text all \\x02\\x7a";

      ## Split pane
      "cmd+d" = "send_text all \\x02\\x25";
      "cmd+shift+d" = "send_text all \\x02\\x22";

      ## Select window
      "cmd+[" = "send_text all \\x02\\x70";
      "cmd+]" = "send_text all \\x02\\x6e";

      "cmd+1" = "send_text all \\x02\\x31";
      "cmd+2" = "send_text all \\x02\\x32";
      "cmd+3" = "send_text all \\x02\\x33";
      "cmd+4" = "send_text all \\x02\\x34";
      "cmd+5" = "send_text all \\x02\\x35";
      "cmd+6" = "send_text all \\x02\\x36";
      "cmd+7" = "send_text all \\x02\\x37";
      "cmd+8" = "send_text all \\x02\\x38";
      "cmd+9" = "send_text all \\x02\\x39";
    };
  };
}
