{ pkgs, config, lib, ... }:

with lib;

let
  cfg = config.programs.browsh;
in
{
  options.programs.browsh = {
    enable = mkEnableOption "browsh, A fully-modern text-based browser, rendering to TTY and browsers";

    package = mkOption {
      type = types.package;
      default = pkgs.browsh;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # xdg.configFile."browsh/config.toml".text = ''
    # '';
  };
}
