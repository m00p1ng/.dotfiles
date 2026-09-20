{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.bun;
in {
  config = mkIf cfg.enable {
    xdg.configFile."fish/completions/bun.fish".source = pkgs.runCommand "bun.fish" {} ''
      ${cfg.package}/bin/bun completions fish > $out
    '';
  };
}
