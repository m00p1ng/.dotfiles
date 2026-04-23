{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.my-config.ghostty;
in {
  config = mkIf cfg.enable {
    xdg.configFile."ghostty" = {
      source = ../../../config/ghostty;
      recursive = true;
    };
  };
}
