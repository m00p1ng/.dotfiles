{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.my-config.ghostty;

  keyValueSettings = {
    listsAsDuplicateKeys = true;
    mkKeyValue = lib.generators.mkKeyValueDefault {} " = ";
  };
  keyValue = pkgs.formats.keyValue keyValueSettings;
in {
  config = mkIf cfg.enable {
    my-config.ghostty = {
      settings = {
        font-size = 14;
        theme = "Catppuccin Mocha";

        cursor-style = "block";
        cursor-style-blink = false;
        cursor-color = "#f2d5cf";
        cursor-text = "#1e1e2e";
        adjust-cursor-thickness = "300%";
        mouse-hide-while-typing = true;

        quit-after-last-window-closed = true;
        window-decoration = true;
        shell-integration-features = "no-cursor";

        macos-option-as-alt = true;
        macos-titlebar-style = "hidden";

        keybind = [
          # Open URL
          "cmd+shift+e=text:\\x02u"

          # Full screen
          "cmd+enter=toggle_fullscreen"

          # Delete
          "cmd+backspace=text:\\x15"
          "opt+backspace=text:\\x17"

          # Tmux mapping
          ## ref: https://www.joshmedeski.com/posts/macos-keyboard-shortcuts-for-tmux
          "cmd+t=text:\\x02c"
          "cmd+w=text:\\x02x"
          "cmd+,=text:\\x02,"
          "cmd+f=text:\\x02[?"

          # Split pane
          "cmd+d=text:\\x02%"
          "cmd+shift+d=text:\\x02\""

          # Select window
          # "cmd+[=text:\\x02p"
          # "cmd+]=text:\\x02n"
          # "cmd+shift+[=text:\\x1b{"
          # "cmd+shift+]=text:\\x1b}"
          #
          # "cmd+1=text:\\x021"
          # "cmd+2=text:\\x022"
          # "cmd+3=text:\\x023"
          # "cmd+4=text:\\x024"
          # "cmd+5=text:\\x025"
          # "cmd+6=text:\\x026"
          # "cmd+7=text:\\x027"
          # "cmd+8=text:\\x028"
          # "cmd+9=text:\\x029"

          "cmd+bracket_left=text:\\x02p"
          "cmd+bracket_right=text:\\x02n"
          "cmd+shift+bracket_left=text:\\x1b{"
          "cmd+shift+bracket_right=text:\\x1b}"

          "cmd+digit_1=text:\\x021"
          "cmd+digit_2=text:\\x022"
          "cmd+digit_3=text:\\x023"
          "cmd+digit_4=text:\\x024"
          "cmd+digit_5=text:\\x025"
          "cmd+digit_6=text:\\x026"
          "cmd+digit_7=text:\\x027"
          "cmd+digit_8=text:\\x028"
          "cmd+digit_9=text:\\x029"

          # fix claude code new line
          "shift+enter=text:\\x1b\\r"
        ];
      };
    };

    xdg.configFile."ghostty/config" = {
      source = keyValue.generate "ghostty-config" cfg.settings;
    };
  };
}
