{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.ghostty-config;
in {
  options.programs.ghostty-config = {
    enable = mkEnableOption "ghostty terminal config";
  };

  config = mkIf cfg.enable {
    xdg.configFile."ghostty" = {
      source = ../../config/ghostty;
      recursive = true;
    };
  };
}
