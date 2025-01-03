{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.nix-development;
in {
  options.programs.nix-development = {
    enable = mkEnableOption "nix development tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nixd
      alejandra
    ];
  };
}
