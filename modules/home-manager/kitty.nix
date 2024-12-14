{
  programs.kitty = {
    settings = {
      # Patched font
      # ref: https://www.reddit.com/r/KittyTerminal/comments/r5hssh/kitty_nerd_fonts/
      font_size = 14;
      font_family = "JetBrains Mono";

      cursor_shape = "block";
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
    };
    themeFile = "Catppuccin-Mocha";
    extraConfig = ''
      # Seti-UI + Custom
      symbol_map U+E5FA-U+E62B Menlo Nerd Font
      # Devicons
      symbol_map U+E700-U+E7C5 Menlo Nerd Font
      # Font Awesome
      symbol_map U+F000-U+F2E0 Menlo Nerd Font
      # Font Awesome Extension
      symbol_map U+E200-U+E2A9 Menlo Nerd Font
      # Material Design Icons
      symbol_map U+F500-U+FD46 Menlo Nerd Font
      # Weather
      symbol_map U+E300-U+E3EB Menlo Nerd Font
      # Octicons
      symbol_map U+F400-U+F4A8,U+2665,U+26A1,U+F27C Menlo Nerd Font
      # Powerline Extra Symbols
      symbol_map U+E0A3,U+E0B4-U+E0C8,U+E0CC-U+E0D2,U+E0D4 Menlo Nerd Font
      # IEC Power Symbols
      symbol_map U+23FB-U+23FE,U+2b58 Menlo Nerd Font
      # Font Logos
      symbol_map U+F300-U+F313 Menlo Nerd Font
      # Pomicons
      symbol_map U+E000-U+E00D Menlo Nerd Font
      symbol_map U+F101-U+F208 Menlo Nerd Font
      symbol_map U+EA60-U+EBD1 Menlo Nerd Font
    '';
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
