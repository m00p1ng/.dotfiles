{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.programs.ghostty;
in
{
  options.programs.ghostty = {
    enable = mkEnableOption "ghostty terminal";
  };

  config = mkIf cfg.enable {
    xdg.configFile."ghostty" = {
      source = ../../config/ghostty;
      recursive = true;
    };
  };
}
