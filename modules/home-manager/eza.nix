{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.programs.eza;
in {
  config = mkIf cfg.enable {
    programs.eza = {
      icons = "auto";
      extraOptions = [
        "--group-directories-first"
      ];
    };

    programs.fish = {
      shellAliases = {
        ls = "eza";
      };
    };
  };
}
