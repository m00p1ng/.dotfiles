{ config, lib, pkgs, username, ... }:

with lib;
let
  cfg = config.services.skhd;
in
{
  config = mkIf cfg.enable {
    services.skhd = {
      skhdConfig = ''
        # focus window
        alt - h : yabai -m window --focus west
        alt - j : yabai -m window --focus south
        alt - k : yabai -m window --focus north
        alt - l : yabai -m window --focus east
        alt - n : yabai -m window --focus stack.next || \
                  yabai -m window --focus stack.first || \
                  yabai -m window --focus next || \
                  yabai -m window --focus first
        alt - p : yabai -m window --focus stack.prev || \
                  yabai -m window --focus stack.last || \
                  yabai -m window --focus prev || \
                  yabai -m window --focus last

        # swap managed window
        alt + shift - h : yabai -m window --swap west
        alt + shift - j : yabai -m window --swap south
        alt + shift - k : yabai -m window --swap north
        alt + shift - l : yabai -m window --swap east

        alt + shift - n : yabai -m window --swap next || \
                          yabai -m window --swap first
        alt + shift - p : yabai -m window --swap prev || \
                          yabai -m window --swap last

        alt - x : yabai -m space --mirror x-axis
        alt - y : yabai -m space --mirror y-axis
        alt + shift - 0 : yabai -m space --balance
        alt + shift - r : yabai -m space --rotate 270

        alt + shift - q : yabai -m space --layout float; sketchybar --trigger window_focus
        alt + shift - w : yabai -m space --layout bsp; sketchybar --trigger window_focus
        alt + shift - e : yabai -m space --layout stack; sketchybar --trigger window_focus

        # Example for sketchybar config
        alt - space : yabai -m window --toggle float
        alt - f : yabai -m window --toggle zoom-parent
        alt + shift - f : yabai -m window --toggle zoom-fullscreen
      '';
    };

    # ref: https://github.com/LnL7/nix-darwin/pull/260
    environment.systemPackages = [ cfg.package ];
  };
}
