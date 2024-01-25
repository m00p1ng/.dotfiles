{ config, lib, pkgs, username, ... }:

with lib;
let
  cfg = config.services.sketchybar;
in
{
  config = mkIf cfg.enable {
    system.defaults.NSGlobalDomain._HIHideMenuBar = true;
    services.yabai.config.external_bar = "all:28:0";

    home-manager = {
      users.${username} = {
        programs = {
          kitty = {
            settings = {
              hide_window_decorations  = "titlebar-only";
            };
          };
        };
      };
    };
  };
}
