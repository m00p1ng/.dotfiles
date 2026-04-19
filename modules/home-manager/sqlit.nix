{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.sqlit;
in {
  options.programs.sqlit = {
    enable = mkEnableOption "sqlit";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      sqlit-tui
    ];
  };
}
