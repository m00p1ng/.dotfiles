{ pkgs, config, lib, ... }:

with lib;

let
  cfg = config.programs.browsh;
in
{
  options.programs.browsh = {
    enable = mkEnableOption "browsh, A fully-modern text-based browser, rendering to TTY and browsers";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      browsh
    ];

    # xdg.configFile."browsh/config.toml".text = ''
    # '';
  };
}
