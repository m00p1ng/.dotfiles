{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.node;
in {
  options.programs.node = {
    enable = mkEnableOption "node";
    package = mkOption {
      type = types.package;
      default = pkgs.fnm;
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = [cfg.package];

      programs.fish = {
        interactiveShellInit = ''
          # FNM configuration
          ${cfg.package}/bin/fnm env --use-on-cd | source
          ${cfg.package}/bin/fnm completions --shell fish | source
        '';
      };
    }
  ]);
}
