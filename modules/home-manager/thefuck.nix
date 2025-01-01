{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.programs.thefuck;
in
{
  config = mkIf cfg.enable {
    programs.fish = {
      shellAliases = {
        f = "fuck";
      };
    };
  };
}
