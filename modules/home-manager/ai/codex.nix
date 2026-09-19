{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.codex;
in {
  config = mkIf cfg.enable {
    xdg.configFile."fish/completions/codex.fish".source = pkgs.runCommand "codex.fish" {} ''
      ${cfg.package}/bin/codex completion fish > $out
    '';
  };
}
