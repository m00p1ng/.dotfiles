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
        shellInit = ''
          # FNM configuration
          ${cfg.package}/bin/fnm env --use-on-cd | source

          # Global npm path
          fish_add_path ${config.home.homeDirectory}/.npm-global/node_modules/.bin
        '';
        interactiveShellInit = ''
          # FNM configuration
          ${cfg.package}/bin/fnm completions --shell fish | source
        '';
      };
    }
  ]);
}
