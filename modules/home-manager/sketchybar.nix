{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.programs.sketchybar;
in
{
  options.programs.sketchybar = {
    enable = mkEnableOption "sketchybar, A highly customizable macOS status bar replacement";

    package = mkOption {
      type = types.package;
      default = pkgs.sketchybar;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # xdg.configFile."sketchybar/sketchybarrc".text = ''
    # '';
  };
}
